# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"
SLOT="0"

inherit eutils
LICENSE="BEER-WARE"
FEATURES="sandbox collision-protect strict"
DESCRIPTION="This project is containing bumblebee (Formerly known as prime-ng).\
Bumblebee is Optimus support for Linux, with real offloading, and not\
switchable graphics.. More important.. it works on Optimus Laptops without a\
graphical multiplexer..\
Bumblebee Supports: Ubuntu, Linux Mint, OpenSuSE and Fedora. More\
are coming."
HOMEPAGE="https://github.com/MrMEEE/bumblebee-Old-and-abbandoned"
KEYWORDS="~amd64 ~x86"
SRC_URI=""
# PROPERTIES="interactive"
ECHOCONNECTEDMONITORTYPE="monitor_connect_type_CTR-0 monitor_connect_type_DFP-0"
CONNECTEDMONITOR="UNDEFINED"
ECHOMACHINE_PRODUCT_NAME="machine_U30J machine_UL30VT machine_U30JC machine_U31JG machine_P31JG machine_U35J machine_U36JC machine_U43JC machine_U35JC machine_U43JC machine_U53JC machine_P52JC machine_K52JC machine_X52JC machine_N53SV machine_X53SV machine_N61Jv machine_X64JV machine_N73JN machine_0PXM4R machine_1215N machine_5745PG machine_5742G machine_8951G"
MACHINE_PRODUCT_NAME="UNDEFINED"
IUSE="video_cards_nvidia acpicall ${ECHOCONNECTEDMONITORTYPE} ${ECHOMACHINE_PRODUCT_NAME}"

DEPEND="
acpicall? ( sys-power/acpi_call )
sys-apps/dmidecode"

RDEPEND="${DEPEND}
x11-misc/virtualgl
sys-apps/dmidecode
x11-base/xorg-drivers[video_cards_nvidia?]
x11-drivers/nvidia-drivers"

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

# Directory to store default config for bumblebee
BUMBLEBEE_DEFAULT_CONFIG_DIR=/etc/bumblebee

# Directory to store our backup so we stop poluting in etc
CONF_BACKUP_DIR=${BUMBLEBEE_DEFAULT_CONFIG_DIR}/configs_backup
S="${WORKDIR}/${PN}"

src_unpack() {
	einfo "WELCOME to the bumblebee \"${PV}\" installation"
	einfo "Licensed under BEER-WARE License and GPL"
	einfo "This will enable you to utilize both your Intel and nVidia card"

	mkdir ${S}
	
	# Copy xorg config files for modification
	cp -L ${FILESDIR}/xorg.conf.nvidia ${S}/xorg.conf.nvidia

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

	0) CONNECTEDMONITOR="CRT-0";;
	1) CONNECTEDMONITOR="DFP-0";;
	2) CONNECTEDMONITOR="CRT-0";;
	3) CONNECTEDMONITOR="DFP-0";;
	4) CONNECTEDMONITOR="DFP-0";;
	5) CONNECTEDMONITOR="DFP-0";;
	6) CONNECTEDMONITOR="DFP-0";;
	7) CONNECTEDMONITOR="CRT-0";;
	8) CONNECTEDMONITOR="CRT-0";;
	9) CONNECTEDMONITOR="CRT-0";;
	10) CONNECTEDMONITOR="CRT-0";;
	11) CONNECTEDMONITOR="CRT-0";;
	12) CONNECTEDMONITOR="CRT-0";;
	13) CONNECTEDMONITOR="DFP-0";;
	97) CONNECTEDMONITOR="CRT-0";;
	98) CONNECTEDMONITOR="DFP-0";;
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

src_prepare() {
	# Determinig bus ids for our cards
	# NOTE: That can be copied from MrMEEE's laptop database,
	# see "bumblebee-submitsystem", (will be introduced later)
	# INTELBUSID=`echo "PCI:"\`lspci |grep VGA |grep Intel |cut -f1 -d:\`":"\`lspci |grep VGA |grep Intel |cut -f2 -d: |cut -f1 -d.\`":"\`lspci |grep VGA |grep Intel |cut -f2 -d. |cut -f1 -d" "\``
#	NVIDIABUSID=`echo "PCI:"\`lspci |grep VGA |grep nVidia |cut -f1 -d:\`":"\`lspci |grep VGA |grep nVidia |cut -f2 -d: |cut -f1 -d.\`":"\`lspci |grep VGA |grep nVidia |cut -f2 -d. |cut -f1 -d" "\``
	NVIDIABUSID=$(echo "PCI:"$(lspci|grep VGA|grep NVIDIA|cut -f1 -d:)":"$(lspci|grep VGA|grep NVIDIA|cut -f2 -d:|cut -f1 -d.)":"$(lspci|grep VGA|grep NVIDIA|cut -f2 -d.|cut -f1 -d' '))
	einfo "NVIDIABUSID: ${NVIDIABUSID}"

	# Now check the laptop model
#	einfo "For now laptop model is set to default N61Jv, that will be changed when"
#	einfo "I will have a way to parse dmidecode output like \"Product Name: N61Jv\""
	MACHINE_PRODUCT_NAME=$(dmidecode --string system-product-name)
	einfo "MACHINE_PRODUCT_NAME: ${MACHINE_PRODUCT_NAME}"

	# We need to set arch name here before installation of VGL began
	# Little hack to work around i686 <-> i386 package names.
	if [ "${ARCH}" = "i686" ]; then
		ARCH="i386"
	fi
	einfo "ARCH: ${ARCH}"

	# Way to configure monitor connection type automatically
	# Unfortunately it can't be used unless nvidia card is enabled with acpi_call command
	# I will leave that for now and deal with it in the future
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

	"U30J"|"UL30VT"|"U30JC"|"U31JG"|"P31JG"|"U35J"|"U36JC"|"U43JC"|"U35JC"|\
	"U43JC"|"U53JC"|"P52JC"|"K52JC"|"X52JC"|"N53SV"|"X53SV"|"N61Jv"|"X64JV"|\
	"N73JN"|"0PXM4R")
		CONNECTEDMONITOR="CRT-0"
	;;

	"1215N"|"5745PG"|"5742G"|"8951G")
		CONNECTEDMONITOR="DFP-0"
	;;

	*)
		echo "Can't determine your lcd pane connection type automatically"
		echo "Please enter it manually"
		manual_set_connection_type
	;;

	esac

	shopt -u nocasematch

	einfo "CONNECTEDMONITOR: [ ${CONNECTEDMONITOR} ]"

	# Now set options for xorg config files
	sed -i 's/REPLACEWITHBUSID/'${NVIDIABUSID}'/g' ${S}/xorg.conf.nvidia || ( eend 1 && die "Can't access /etc/X11/xorg.conf.nvidia for configuration" )
	sed -i 's/REPLACEWITHCONNECTEDMONITOR/'${CONNECTEDMONITOR}'/g' ${S}/xorg.conf.nvidia || ( eend 1 && die "Can't access /etc/X11/xorg.conf.nvidia for configuration" )

	# Set new bumblebee group
#	ebegin "Create bumblebee group and add us there"
#		enewgroup bumblebee
#	eend 0
}

src_install() {
	# Creating directory to store bumblebee beckups and default settings
#	dodir ${CONF_BACKUP_DIR}
#	ebegin "Backing up your Configuration"
#		cp -n /etc/conf.d/modules "${CONF_BACKUP_DIR}"/modules.optiorig
		# cp -n /etc/X11/xorg.conf "${CONF_BACKUP_DIR}"/xorg.conf.optiorig
#	eend 0
#	einfo "Your config backups will be stored in ${CONF_BACKUP_DIR}"

	# Setting up and configuring xorg.config.nvidia file
	einfo "Copying X11 configs"
	insinto /etc/X11/
	doins ${S}/xorg.conf.nvidia

	# Copy bumblebee specific executables into /usr/local/bin
	ebegin "Copying bumblebee specific files"
		exeinto /usr/local/bin
		doexe ${FILESDIR}/bumblebee-bugreport || ( eend 1 && die )
		doexe ${FILESDIR}/bumblebee-submitsystem || ( eend 1 && die )
		doexe ${FILESDIR}/bumblebee-enablecard || ( eend 1 && die )
		doexe ${FILESDIR}/bumblebee-disablecard || ( eend 1 && die )

		# Installing default configuration
		insinto ${BUMBLEBEE_DEFAULT_CONFIG_DIR}
		newins ${FILESDIR}/bumblebee.default bumblebee || ( eend 1 && die )

		# Installing documentation
		insinto /usr/share/doc/bumblebee
		doins ${FILESDIR}/documentation || ( eend 1 && die )
	eend 0

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
			# dosym /usr/local/bin/optirun64 /usr/local/bin/optirun
		elif [ "${ARCH}" = "i386" ]; then
			newexe ${FILESDIR}/optirun32 optirun
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
}

# pkg_preinst() {
	# probe all modules
# 	depmod -a
# 	ldconfig
	# Removing nouveau module and put it to blacklist
# 	modprobe -r nouveau

	# Check if nouveau is in blacklist.conf
# 	ebegin "Remove nouveau from /etc/modprobe.d/backlist.conf"
# #	if [ "`cat /etc/modprobe.d/blacklist.conf |grep "blacklist nouveau" |wc -l`" -ne "0" ]; then
# 		if [ "$(cat /etc/modprobe.d/blacklist.conf |grep "blacklist nouveau" |wc -l)" -ne "0" ]; then
# 			grep -Ev 'nouveau' /etc/modprobe.d/blacklist.conf > /tmp/blacklist.conf
# 			mv /tmp/blacklist.conf /etc/modprobe.d/blacklist.conf
# 		fi
# 	eend 0

	# Add nouveau into blacklist if not present in blacklist
# 	echo "blacklist nouveau" >> /etc/modprobe.d/nouveau-blacklist.conf

	# Adding module to load list (for baselayout 2) and then inserting it
# 	modprobe nvidia

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
# }

pkg_postinst() {
	# ebegin "Enabling bumblebee Service"
	# /etc/init.d/xdm-optimus start

	echo "Current project depends on some libraries and other packages \
	 1. Captain obvious warns you that you will have to install nvidia-drivers package \
	 2. Bumblebee using acpi_call module to switch nvidia graphics on|off \
	   home page of acpi_call project is https://github.com/mkottman/acpi_call \
	   bugs.gentoo.org contains info about existing ebuild. \
	   http://bugs.gentoo.org/356605 \
	   Written by Maxim Koltsov \
	   When I contacted him he said that he commited acpi_call abuild into tree, so \
	   hopefully it will appear there soon. \
	   But for now I will use sunrise overlay ebuild called sys-power/acpi_call-9999 \
	 3. Bumblebee is also using VirtualGL to be able to render with nvidia card \
	   home page for that is till unknown to me. \
	   bugs.gentoo.org contains info on VirtualGL existing ebuild. \
	   http://bugs.gentoo.org/313305 \
	   I plan to use VirtualGL ebuild written by Steven Peckins \
	   I have wrote a letter to author and I will include ebuild as soon as I receive any \
	   answer from him, hopefully with home page :)"

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
	ewarn "REMEMBER! No nouveau support, so unload it and blacklist it"
	einfo "If you want you can add nvidia module to autoload."
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
i	echo "And please... I your system is working.. run the bumblebee-submitsystem utility"
	echo
	echo "Good luck...	MrMEEE / Martin Juhl"
	echo "				rainman / Iegor Danylchenko"
	echo
	echo "http://www.martin-juhl.dk, http://twitter.com/martinjuhl, https://github.com/MrMEEE/bumblebee"
	echo "https://github.com/iegor"
}
