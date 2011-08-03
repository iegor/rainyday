# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit git rpm

# EGIT_REPO_URI="git://github.com/MrMEEE/bumblebee.git"
# https://github.com/MrMEEE/bumblebee.git

DESCRIPTION="This project is containing bumblebee (Formerly known as prime-ng).\
Bumblebee is Optimus support for Linux, with real offloading, and not\
switchable graphics.. More important.. it works on Optimus Laptops without a\
graphical multiplexer..\
Bumblebee Supports: Ubuntu, Linux Mint, OpenSuSE and Fedora. More\
are coming."
HOMEPAGE="https://github.com/MrMEEE/bumblebee"
SRC_URI=""

#EGIT_REPO_URI=git://github.com/iegor/bumblebee-Gentoo-support.git
EGIT_REPO_URI="git://github.com/MrMEEE/bumblebee.git"
EGIT_BRANCH=master

LICENSE="BEER-WARE"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nvidia"
PROPERTIES="interactive"
FEATURES="sandbox collision-protect strict"

CATEGORY="app-misc"

MERGE_TYPE="binary"

# Current project depends on some libraries and other packages
# 1. Captain obvious is warns you that you will have to install nvidia-drivers package
# 2. Bumblebee using acpi_call module to switch nvidia graphics on|off
#   home page of acpi_call project is https://github.com/mkottman/acpi_call
#   bugs.gentoo.org contains info about existing ebuild.
#   http://bugs.gentoo.org/356605
#   Written by Maxim Koltsov
#   When I contacted him he said that he commited acpi_call abuild into tree, so
#   hopefully it will appear there soon.
#   But for now I will use sunrise overlay ebuild called sys-power/acpi_call-9999
# 3. Bumblebee is also using VirtualGL to be able to render with nvidia card
#   home page for that is till unknown to me.
#   bugs.gentoo.org contains info on VirtualGL existing ebuild.
#   http://bugs.gentoo.org/313305
#   I plan to use VirtualGL ebuild written by Steven Peckins
#   I have wrote a letter to author and I will include ebuild as soon as I receive any 
#   answer from him, hopefully with home page :)

DEPEND="x11-drivers/nvidia-drivers
sys-power/acpi_call
x11-apps/mesa-progs
sys-apps/dmidecode
app-arch/rpm"
# We needed libselinux only for launching xdm-optimus binary executable
# Now when it is completely removed from bumblebee it is not used by us
#	"sys-libs/libselinux"
RDEPEND="${DEPEND}"

# What version of bumblebee do we use ?
BUMBLEBEEVERSION=1.6.40

#DISTRO="gentoo"
#BUMBLEBEEPWD=${PWD}

# Setting monitor connection type
CONNECTEDMONITOR="UNDEFINED"

# "The Image Transport is how the images are transferred from the"
# "nVidia card to the Intel card, people has different experiences of"
# "performance, but just select the default if you are in doubt."
#
# "I recently found out that yuv and jpeg both has some lagging"
# "this is only noticable in fast moving games, such as 1st person"
# "shooters and for me, its only good enough with xv, even though"
# "xv sets down performance a little bit."
#
# "1) YUV"
# "2) JPEG"
# "3) PROXY"
# "4) XV (default)"
# "5) RGB"
#IMAGETRANSPORT="xv"

POWERON="UNDEFINED"
POWEROFF="UNDEFINED"
INTELBUSID="UNDEFINED"
NVIDIABUSID="UNDEFINED"

# Determine Arch x86_64 or i686
ARCH=$(uname -m)

# We need to know what laptop we are running
MACHINE_PRODUCT_NAME="UNDEFINED"

small_debug_foo() {
	echo ROOT_UID "[ ${ROOT_UID} ]"
	echo HOME "[ ${HOME} ]"
	echo ARCH "[ ${ARCH} ]"
	echo PORTAGE_TMPDIR "[ ${PORTAGE_TMPDIR} ]"
	echo M "[ ${M} ]"
	echo S "[ ${S} ]"
	echo D "[ ${D} ]"
	# should be /var/tmp/portage/app-misc/bumblebee-1.1.2-r42/work
	echo WORKDIR "[  ${WORKDIR}  ]"
}

# Probably will need to specify EGIT_STORE_DIR manually
# EGIT_STORE_DIR

# Directory to store default config for bumblebee
BUMBLEBEE_DEFAULT_CONFIG_DIR=/etc/default/bumblebee

# Directory to store our backup so we stop poluting in etc
CONF_BACKUP_DIR=${BUMBLEBEE_DEFAULT_CONFIG_DIR}/configs_backup

# Creating my own path variable containing path to current version of bumblebee
# and modifying S path
MY_P=bumblebee-${BUMBLEBEEVERSION}
S="${WORKDIR}/${MY_P}"

check_rights() {
	ebegin "Checking user rights"
	ROOT_UID=0
	if [ ${UID} != ${ROOT_UID} ]; then
		eerror "You don't have sufficient privileges to run this script."
		eend 1
		return 1
	fi

	if [ ${HOME} = /root ]; then
		eerror "Do not run this script as the root user"
		eend 1
		return 1
	fi

	eend 0
	return 0
}

check_machine() {
	ebegin "Determining laptop model"
#		einfo "For now laptop model is set to default N61Jv, that will be changed when"
#		einfo "I will have a way to parse dmidecode output like \"Product Name: N61Jv\""
		MACHINE_PRODUCT_NAME=$(dmidecode --string system-product-name)
	eend 0

	echo "Detected Poduct Name: [ ${MACHINE_PRODUCT_NAME} ]"

	# We need to set arch name here before installation of VGL began
	# Little hack to work around i686 <-> i386 package names.
	if [ "${ARCH}" = "i686" ]; then
		ARCH="i386"
	fi
}

# Manual selection of connection type for users monitor
# Try to determine a monitor connection type that used
manual_set_connection_type() {
	echo
	echo "Select your Laptop:"
	echo "0) Alienware M11X R1/R2"  
	echo "1) Dell XPS 15/17 L502x/L702x"
	echo "2) Dell XPS 15/17 L501x/L701x"  
	echo "3) CLEVO W150HNQ"   
	echo "4) Asus EeePC 1215N"
	echo "5) Acer Aspire 5745PG/5742G/8951G"
	echo "6) Dell Vostro 3300"
	echo "7) Dell Vostro 3400/3500/3700"
	echo "8) Samsung RF511/RF711/QX410-J01/QX310"
	echo "9) Toshiba Satellite M645-SP4132L"
	echo "10) Asus U30J/UL30VT/U30JC/U31JG/P31JG/U35J/U36JC/U43JC/U35JC/U43JC/U53JC/P52JC/K52JC/X52JC/N53SV/X53SV/N61Jv/X64JV/N73JN"
	echo "11) Dell Latitude E6420"
	echo "12) MSI FX700"
	echo "13) Lenovo T410"
	echo
	echo "97) Manually Set Output to CRT-0"
	echo "98) Manually Set Output to DFP-0"
	echo "99) Manually Enter Output"
	
	echo
	read machine
	echo
	
	case "${machine}" in

	0)
	CONNECTEDMONITOR="CRT-0"
	;;

	1)
	CONNECTEDMONITOR="DFP-0"
	;;
	
	2)
	CONNECTEDMONITOR="CRT-0"
	;;
	
	3)
	CONNECTEDMONITOR="DFP-0"
	;;
	
	4)
	CONNECTEDMONITOR="DFP-0"
	;;
	
	5)
	CONNECTEDMONITOR="DFP-0"
	;;
	
	6)
	CONNECTEDMONITOR="DFP-0"
	;;
	
	7)
	CONNECTEDMONITOR="CRT-0"
	;;
	
	8)
	CONNECTEDMONITOR="CRT-0"
	;;
	
	9)
	CONNECTEDMONITOR="CRT-0"
	;;
	
	10)
	CONNECTEDMONITOR="CRT-0"
	;;
	
	11) 
	CONNECTEDMONITOR="CRT-0"
	;;
	
	12)
	CONNECTEDMONITOR="CRT-0"
	;;
	
	13)
	CONNECTEDMONITOR="DFP-0"
	;;
	
	
	97)
	CONNECTEDMONITOR="CRT-0"
	;;
	
	98)
	CONNECTEDMONITOR="DFP-0"
	;;
	
	99)
	echo
	echo "Enter output device for nVidia Card"
	echo
	read manualinput
	CONNECTEDMONITOR=`echo ${manualinput}`
	;;
	
	
	*)
	echo
	ewarn "You did not entered your laptop model, Default will be used (CTR-0)"
	CONNECTEDMONITOR="CRT-0"
	;;
	
	esac
}

# Conducting "installation" of VGL, probably will be replaced in future by some
# existent ebuilds
virtual_gl_ala_install_improvisation() {
	
	# ebegin "Creating a directory tree for VGL"
	# mkdir -p /opt/VirtualGL/fakelib/64
	# mkdir -p /opt/VirtualGL/bin
	# mkdir -p /opt/VirtualGL/include
	# eend 0

	# Install
	vglver=2.2.2
	ebegin "Installing VGL files into your ${ARCH} system"
		exeinto /opt/VirtualGL/bin
		doexe ${S}/install-files/VirtualGL.${ARCH}/opt/VirtualGL/bin/cpustat || ( eend 1 && return 1 )
		doexe ${S}/install-files/VirtualGL.${ARCH}/opt/VirtualGL/bin/glxinfo || ( eend 1 && return 1 )
		doexe ${S}/install-files/VirtualGL.${ARCH}/opt/VirtualGL/bin/glxspheres || ( eend 1 && return 1 )
		doexe ${S}/install-files/VirtualGL.${ARCH}/opt/VirtualGL/bin/nettest || ( eend 1 && return 1 )
		doexe ${S}/install-files/VirtualGL.${ARCH}/opt/VirtualGL/bin/tcbench || ( eend 1 && return 1 )

		exeinto /usr/bin
		doexe ${S}/install-files/VirtualGL.${ARCH}/usr/bin/vglclient || ( eend 1 && return 1 )
		dosym /usr/bin/vglclient	/opt/VirtualGL/bin/vglclient || ( eend 1 && return 1 )

		doexe ${S}/install-files/VirtualGL.${ARCH}/usr/bin/vglconfig || ( eend 1 && return 1 )
		dosym /usr/bin/vglconfig	/opt/VirtualGL/bin/vglconfig || ( eend 1 && return 1 )

		doexe ${S}/install-files/VirtualGL.${ARCH}/usr/bin/vglconnect || ( eend 1 && return 1 )
		dosym /usr/bin/vglconnect	/opt/VirtualGL/bin/vglconnect || ( eend 1 && return 1 )

		doexe ${S}/install-files/VirtualGL.${ARCH}/usr/bin/vglgenkey || ( eend 1 && return 1 )
		dosym /usr/bin/vglgenkey	/opt/VirtualGL/bin/vglgenkey || ( eend 1 && return 1 )

		doexe ${S}/install-files/VirtualGL.${ARCH}/usr/bin/vgllogin || ( eend 1 && return 1 )
		dosym /usr/bin/vgllogin		/opt/VirtualGL/bin/vgllogin || ( eend 1 && return 1 )

		doexe ${S}/install-files/VirtualGL.${ARCH}/usr/bin/vglrun || ( eend 1 && return 1 )
		dosym /usr/bin/vglrun		/opt/VirtualGL/bin/vglrun || ( eend 1 && return 1 )

		doexe ${S}/install-files/VirtualGL.${ARCH}/usr/bin/vglserver_config || ( eend 1 && return 1 )
		dosym /usr/bin/vglserver_config		/opt/VirtualGL/bin/vglserver_config || ( eend 1 && return 1 )

		if [ "${ARCH}" = "x86_64" ]; then
			exeinto /opt/VirtualGL/bin
			doexe ${S}/install-files/VirtualGL.${ARCH}/opt/VirtualGL/bin/glxspheres64 || ( eend 1 && return 1 )

			insinto /usr/lib64
			newins ${S}/install-files/VirtualGL.${ARCH}/usr/lib64/libdlfaker.so libdlfaker.so.${vglver} || ( eend 1 && return 1 )
			dosym /usr/lib64/libdlfaker.so.${vglver} /usr/lib64/libdlfaker.so || ( eend 1 && return 1 )
			newins ${S}/install-files/VirtualGL.${ARCH}/usr/lib64/libgefaker.so libgefaker.so.${vglver} || ( eend 1 && return 1 )
			dosym /usr/lib64/libgefaker.so.${vglver} /usr/lib64/libgefaker.so || ( eend 1 && return 1 )
			newins ${S}/install-files/VirtualGL.${ARCH}/usr/lib64/librrfaker.so librrfaker.so.${vglver} || ( eend 1 && return 1 )
			dosym /usr/lib64/librrfaker.so.${vglver}	/usr/lib64/librrfaker.so || ( eend 1 && return 1 )
			dosym /usr/lib64/librrfaker.so.${vglver}	/opt/VirtualGL/fakelib/64/libGL.so || ( eend 1 && return 1 )

			insinto /usr/lib32
			newins ${S}/install-files/VirtualGL.${ARCH}/usr/lib/libdlfaker.so libdlfaker.so.${vglver} || ( eend 1 && return 1 )
			dosym /usr/lib32/libdlfaker.so.${vglver} /usr/lib32/libdlfaker.so || ( eend 1 && return 1 )
			newins ${S}/install-files/VirtualGL.${ARCH}/usr/lib/libgefaker.so libgefaker.so.${vglver} || ( eend 1 && return 1 )
			dosym /usr/lib32/libgefaker.so.${vglver} /usr/lib32/libgefaker.so || ( eend 1 && return 1 )
			newins ${S}/install-files/VirtualGL.${ARCH}/usr/lib/librrfaker.so librrfaker.so.${vglver} || ( eend 1 && return 1 )
			dosym /usr/lib32/librrfaker.so.${vglver}	/usr/lib32/librrfaker.so || ( eend 1 && return 1 )
			dosym /usr/lib32/librrfaker.so.${vglver}	/opt/VirtualGL/fakelib/libGL.so || ( eend 1 && return 1 )
		elif [ "${ARCH}" = "i386" ]; then
			insinto /usr/lib
			newins ${S}/install-files/VirtualGL.${ARCH}/usr/lib/libdlfaker.so libdlfaker.so.${vglver} || ( eend 1 && return 1 )
			dosym /usr/lib/libdlfaker.so.${vglver} /usr/lib/libdlfaker.so || ( eend 1 && return 1 )
			newins ${S}/install-files/VirtualGL.${ARCH}/usr/lib/libgefaker.so libgefaker.so.${vglver} || ( eend 1 && return 1 )
			dosym /usr/lib/libgefaker.so.${vglver} /usr/lib/libgefaker.so || ( eend 1 && return 1 )
			newins ${S}/install-files/VirtualGL.${ARCH}/usr/lib/librrfaker.so librrfaker.so.${vglver} || ( eend 1 && return 1 )
			dosym /usr/lib/librrfaker.so.${vglver}	/usr/lib/librrfaker.so || ( eend 1 && return 1 )
			dosym /usr/lib/librrfaker.so.${vglver}	/opt/VirtualGL/fakelib/libGL.so || ( eend 1 && return 1 )
		fi

		insinto /usr/include
		newins ${S}/install-files/VirtualGL.${ARCH}/usr/include/rr.h	rr.h || ( eend 1 && return 1 )
		dosym /usr/include/rr.h	/opt/VirtualGL/include/rr.h || ( eend 1 && return 1 )

		newins ${S}/install-files/VirtualGL.${ARCH}/usr/include/rrtransport.h	rrtransport.h || ( eend 1 && return 1 )
		dosym /usr/include/rrtransport.h	/opt/VirtualGL/include/rrtransport.h || ( eend 1 && return 1 )

		insinto "/usr/share/doc/VirtualGL-${vglver}"
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/411.gif" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/422.gif" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/444.gif" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/ChangeLog.txt" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/LGPL.txt" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/LICENSE.txt" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/LICENSE-FLTK.txt" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/LICENSE-PuTTY.txt" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/LICENSE-xauth.txt" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/chromium-displaywall.png" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/chromium-sortfirst.png" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/chromium-sortlast.png" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/configdialog.gif" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/exceed1.png" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/exceed2.png" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/exceed3.png" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/exceed6.png" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/index.html" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/somerights20.png" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/sshtunnel.png" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/sunray.png" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/sunrayvgltransport.png" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/vgltransport.png" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/vgltransportservernetwork.png" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/virtualgl.css" || ( eend 1 && return 1 )
		doins "${S}/install-files/VirtualGL.${ARCH}/usr/share/doc/VirtualGL-${vglver}/x11transport.png" || ( eend 1 && return 1 )
		dosym "/usr/share/doc/VirtualGL-${vglver}" "/opt/VirtualGL/doc" || ( eend 1 && return 1 )
	eend 0

	return 0
}

pkg_setup() {
	# ewarn "THIS SCRIPT MUST BE RUN WITH SUDO"

	# Seems obvious, but better safe than sorry
	check_rights || die "Please run the installation with: sudo"

	echo "WELCOME to the bumblebee installation v.${BUMBLEBEEVERSION}"
	echo "Licensed under Red Bull, BEER-WARE License and GPL"
	echo
	echo "This will enable you to utilize both your Intel and nVidia card"
	echo
	echo "Please note that this script will probably only work with Ubuntu,"
	echo "Debian, OpenSuSE and Fedora Based machines"
	echo "and has (by me) only been tested on Ubuntu Natty 11.04 and"
	echo "Fedora 14 but should work on others as well"

	# Determinig bus ids for our cards
	# NOTE: That can be copied from MrMEEE's laptop database,
	# see "bumblebee-submitsystem", (will be introduced later)
	# INTELBUSID=`echo "PCI:"\`lspci |grep VGA |grep Intel |cut -f1 -d:\`":"\`lspci |grep VGA |grep Intel |cut -f2 -d: |cut -f1 -d.\`":"\`lspci |grep VGA |grep Intel |cut -f2 -d. |cut -f1 -d" "\``
	NVIDIABUSID=`echo "PCI:"\`lspci |grep VGA |grep nVidia |cut -f1 -d:\`":"\`lspci |grep VGA |grep nVidia |cut -f2 -d: |cut -f1 -d.\`":"\`lspci |grep VGA |grep nVidia |cut -f2 -d. |cut -f1 -d" "\``

	# Now check the laptop model
	check_machine

	# Way to configure monitor connection type automatically
	# Unfortunately it can't be used unless nvidia card is 
	# enabled with acpi_call command
	# I will leave that for now and deal with it in the
	# future
#	ebegin "Autodetecting monitor connection type"
#	${MODPROBE} nvidia-current
#	${MODPROBE} acpi_call
#	if [ $(LD_LIBRARY_PATH=/usr/lib/nvidia /usr/bin/nvidia-xconfig --query-gpu-info|grep "Display Devices"|cut -f2 -d":") -gt 0 ]; then
#		CONNECTEDMONITOR=$(LD_LIBRARY_PATH=/usr/lib/nvidia /usr/bin/nvidia-xconfig --query-gpu-info|grep "Display Device 0"|cut -f2 -d\( | cut -f1 -d\))
#	fi
#	${MODPROBE} -r nvidia-current
#	${MODPROBE} -r acpi_call
#	eend 0

	# turn off case sensitivity for this comparison only
	shopt -s nocasematch

	case ${MACHINE_PRODUCT_NAME} in

	"U30J"|\
	"UL30VT"|\
	"U30JC"|\
	"U31JG"|\
	"P31JG"|\
	"U35J"|\
	"U36JC"|\
	"U43JC"|\
	"U35JC"|\
	"U43JC"|\
	"U53JC"|\
	"P52JC"|\
	"K52JC"|\
	"X52JC"|\
	"N53SV"|\
	"X53SV"|\
	"N61Jv"|\
	"X64JV"|\
	"N73JN"|\
	"0PXM4R")
		CONNECTEDMONITOR="CRT-0"
	;;

	"1215N"|\
	"5745PG"|\
	"5742G"|\
	"8951G")
		CONNECTEDMONITOR="DFP-0"
	;;

	*)
		echo "Can't determine your lcd pane connection type automatically"
		echo "Please enter it manually"
		manual_set_connection_type
	;;

	esac

	shopt -u nocasematch

	echo "CONNECTEDMONITOR is set to [ ${CONNECTEDMONITOR} ]"

	# Set new bumblebee group
#	ebegin "Create bumblebee group and add us there"
#		enewgroup bumblebee
#	eend 0
}

src_unpack() {
	# Handle MrMEEE's files getting
#	EGIT_REPO_URI="git://github.com/MrMEEE/bumblebee.git"
#	EGIT_BRANCH=master
	ebegin "Getting MrMEEE's repo"
		git_fetch
	eend ${?}

	# Handle unpacking rpm VirtualGL install
	ebegin "Unpacking VirtualGL rpm install for ${ARCH}"
		if [ "${ARCH}" = "x86_64" ]; then
			cd ${S}/install-files/
			rpmunpack ${S}/install-files/VirtualGL.x86_64.rpm
		elif [ "${ARCH}" = "i386" ]; then
			cd ${S}/install-files/
			rpmunpack ${S}/install-files/VirtualGL.i386.rpm
		fi
	eend 0
}

#src_prepare() {
#}

src_install() {
#	echo S "[ ${S} ]"
#	echo D "[ ${D} ]"

	# Creating directory to store bumblebee beckups and default settings
#	dodir ${CONF_BACKUP_DIR}
#	ebegin "Backing up your Configuration"
#		cp -n /etc/conf.d/modules "${CONF_BACKUP_DIR}"/modules.optiorig
		# cp -n /etc/X11/xorg.conf "${CONF_BACKUP_DIR}"/xorg.conf.optiorig
#	eend 0
#	einfo "Your config backups will be stored in ${CONF_BACKUP_DIR}"

	# Setting up and configuring xorg.config.nvidia file
	ebegin "Adjusting xorg.config.nvidia"
#		cp ${FILESDIR}/etc/X11/xorg.conf.intel ${S}
#		cp ${FILESDIR}/etc/X11/xorg.conf.nvidia ${S}	
#		sed -i 's/REPLACEWITHBUSID/'${INTELBUSID}'/g' ${S}/install-files/xorg.conf.intel || ( eend 1 && die "Can't access ${S}/install-files/xorg.conf.intel for configuration" )
		sed -i 's/REPLACEWITHBUSID/'${NVIDIABUSID}'/g' ${S}/install-files/xorg.conf.nvidia || ( eend 1 && die "Can't access ${S}/install-files/xorg.conf.nvidia for configuration" )
		# Setting output device to: CONNECTEDMONITOR variable
		sed -i 's/REPLACEWITHCONNECTEDMONITOR/'${CONNECTEDMONITOR}'/g' ${S}/install-files/xorg.conf.nvidia || ( eend 1 && die "Can't access ${S}/install-files/xorg.conf.nvidia for configuration" )
		# now install modified config files into /etc/X11
		insinto /etc/X11
#		newins "${WORKDIR}/etc/X11/xorg.conf.intel" xorg.conf || die "intel xorg configuration copying failed"
		doins "${S}/install-files/xorg.conf.nvidia" || ( eend 1 && die "nvidia xorg configuration copying failed" )
	eend 0

	# Copy bumblebee specific executables into /usr/local/bin
	ebegin "Copying bumblebee specific files"
		exeinto /usr/local/bin
		doexe ${S}/install-files/bumblebee-bugreport || ( eend 1 && die )
#		doexe ${S}/install-files/bumblebee-uninstall || ( eend 1 && die )
		doexe ${S}/install-files/bumblebee-submitsystem || ( eend 1 && die )
		doexe ${S}/install-files/bumblebee-enablecard || ( eend 1 && die )
		doexe ${S}/install-files/bumblebee-disablecard || ( eend 1 && die )

		# Installing default configuration
		insinto ${BUMBLEBEE_DEFAULT_CONFIG_DIR}
		newins ${S}/install-files/bumblebee.default bumblebee || ( eend 1 && die )

		# Installing documentation
		insinto /usr/share/doc/bumblebee
		doins ${S}/install-files/documentation || ( eend 1 && die )
		doins ${S}/install-files/ubuntu/* || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-disablecard.1015PN || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-disablecard.1215n || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-disablecard.K42Jc.K52Jc.N53Jf.N53Jg.N71JV.N73JF.P52JC.U30JC.U33JC.U35JC.U36JC || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-disablecard.U41SV.N53SN || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-disablecard.U43Jc || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-disablecard.UL30VT || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-disablecard.e6420 || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-disablecard.fedora.N53SV || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-disablecard.m11xr2 || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-disablecard.p31jg || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-disablecard.t410 || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-disablecard.template.fedora || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-disablecard.template.opensuse || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-disablecard.template.ubuntu || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-disablecard.vostro3500 || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-disablecard.xps15 || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-enablecard || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-enablecard.1015PN || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-enablecard.1215n || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-enablecard.K42Jc.K52Jc.N53Jf.N53Jg.N71JV.N73JF.P52JC.U30JC.U33JC.U35JC.U36JC || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-enablecard.U41SV.N53SN || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-enablecard.U43Jc || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-enablecard.UL30VT || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-enablecard.e6420 || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-enablecard.fedora.N53SV || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-enablecard.m11xr2 || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-enablecard.p31jg || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-enablecard.t410 || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-enablecard.template.fedora || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-enablecard.template.opensuse || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-enablecard.template.ubuntu || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-enablecard.vostro3500 || ( eend 1 && die )
#		doins ${S}/install-files/bumblebee-enablecard.xps15 || ( eend 1 && die )
	eend 0

	# Perform installation of VirtualGL
	virtual_gl_ala_install_improvisation || die

	ebegin "Installing bumblebee service"
		newinitd "${FILESDIR}/bumblebee.initd" bumblebee || ( eend 1 && die )
		newconfd "${FILESDIR}/bumblebee.confd" bumblebee || ( eend 1 && die )
	eend 0

	# Install executables to launch apps with bumblebee support
	ebegin "Install optirun executables"
		exeinto /usr/local/bin
		if [ ${ARCH} = "x86_64" ]; then
			doexe ${FILESDIR}/optirun64
			doexe ${FILESDIR}/optirun32
			dosym /usr/local/bin/optirun64 /usr/local/bin/optirun
		elif [ "${ARCH}" = "i386" ]; then
			newexe ${FILESDIR}/optirun64 optirun
		fi
	eend 0

	# Install vgl-client-service
	ebegin "Setup vglclient service"
		exeinto /usr/bin
		doexe ${FILESDIR}/vglclient-service || ( eend 1 && die )

		# Let vglclient-service autorun each time we start
		# This is an awful hack, but I didn't found any way yet around it
#		VGL_CLIENT_USER=$(env |grep SUDO_USER |cut -f2 -d=)
#		exeinto /home/${VGL_CLIENT_USER}/.config/autostart
#		doexe ${S}/install-files/vglclient.desktop || ( eend 1 && die )
		# change owner to current user, who installs bumblebee
#		fowners ${VGL_CLIENT_USER}:${VGL_CLIENT_USER} \
#			/home/${VGL_CLIENT_USER}/.config/autostart/vglclient.desktop
	eend 0

#	die "Hey !!! Debugging interrupt, to see what is going on"
}

pkg_preinst() {
	# probe all modules
	depmod -a

	ldconfig

	# Removing nouveau module and put it to blacklist
	modprobe -r nouveau

	# Check if nouveau is in blacklist.conf
	ebegin "Remove nouveau from /etc/modprobe.d/backlist.conf"
#	if [ "`cat /etc/modprobe.d/blacklist.conf |grep "blacklist nouveau" |wc -l`" -ne "0" ]; then
		if [ "$(cat /etc/modprobe.d/blacklist.conf |grep "blacklist nouveau" |wc -l)" -ne "0" ]; then
			grep -Ev 'nouveau' /etc/modprobe.d/blacklist.conf > /tmp/blacklist.conf
			mv /tmp/blacklist.conf /etc/modprobe.d/blacklist.conf
		fi
	eend 0

	# Add nouveau into blacklist if not present in blacklist
	echo "blacklist nouveau" >> /etc/modprobe.d/nouveau-blacklist.conf

	# Adding module to load list (for baselayout 2) and then inserting it
	modprobe nvidia

	# Add nvidia module into modules autoload list
	# if [ "`cat /etc/modules |grep "nvidia" |wc -l`" -eq "0" ]; then
	#	echo "nvidia" >> /etc/modules
	# fi

	#if [ -d ${HOME}/.kde/Autostart ]; then
	#	if [ -f ${HOME}/.kde/Autostart/vlgclient-service ]; then
	#		rm ${HOME}/.kde/Autostart/vglclient-service
	#	fi
	#	ln -s /usr/bin/vglclient-service ${HOME}/.kde/Autostart/vglclient-service
	#fi
}

pkg_postinst() {
	# ebegin "Enabling bumblebee Service"
	# /etc/init.d/xdm-optimus start

	echo "Please logout and back in"
	echo
	echo "If you want power saving by shutting the nVidia down when not in use."
	echo "Please adjust the scripts:"
	echo "/usr/local/bin/bumblebee-enablecard and"
	echo "/usr/local/bin/bumblebee-disablecard for your machine."
	echo
	echo "Examples and documentation is available in /usr/share/doc/bumblebee/"
	echo
	if [ "${ARCH}" = "x86_64" ]; then
		echo "After that you should be able to start applications with"
		echo "\"optirun32 <application>\" or \"optirun64 <application>\""
		echo "optirun32 can be used for legacy 32-bit applications and Wine Games.."
		echo "Everything else should work on optirun64"
		echo "But... if one doesn't work... try the other"
	elif [ "${ARCH}" = "i386" ]; then
		echo "After that you should be able to start applications with"
		echo "\"optirun <application>\"."
	fi
	echo
	echo "If you have any problems in or after the installation"
	echo "please run the bumblebee-bugreport tool and send me a bugreport."
	echo "to rmtdev@gmail.com"
	echo
	echo "Or even better.. create an issue on github"
	echo "https://github.com/iegor/bumblebee-Gentoo-support"
	echo "this really makes bugfixing much easier for me and faster for you."
	echo
	echo "If you need to reconfigure bumblebee the script"
	echo "bumblebee-config as available."
	echo "but I did not tested it yet under gentoo"
	echo
	echo "And please... I your system is working.. run the bumblebee-submitsystem"
	echo "utility"
	echo
	echo "Good luck...	MrMEEE / Martin Juhl"
	echo "				rainman / Iegor Danylchenko"
	echo
	echo "http://www.martin-juhl.dk, http://twitter.com/martinjuhl, https://github.com/MrMEEE/bumblebee"
}

#pkg_config() {
#	ebegin "<> pkg_config()"
#	eend ${?}
#}
