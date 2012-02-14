# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="This project is set environment, which is using compiz-fusion as wm"
HOMEPAGE="https://github.com/iegor/coldfusion"
SRC_URI=""

LICENSE="BEER-WARE"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="docky extras pulseaudio kde decorations"
FEATURES="sandbox collision-protect strict"

CATEGORY="x11-wm"

MERGE_TYPE="binary"

DEPEND="
	x11-wm/compiz
	x11-plugins/compiz-plugins-main
	x11-apps/ccsm
	decorations? ( x11-wm/emerald )
	extras? ( x11-plugins/compiz-plugins-extra )
	docky? ( gnome-extra/docky )
	gnome-extra/gnome-system-monitor
	x11-misc/xcalendar
	x11-misc/trayer
	x11-misc/xscreensaver
	pulseaudio? ( media-sound/pavucontrol )
	gnome-extra/zenity

	x11-themes/gtk-engines-equinox
"
RDEPEND="${DEPEND}"

CF_VERSION=0.0.1

# Creating my own path variable containing path to current version of bumblebee
# and modifying S path
MY_P=coldfusion-${CF_VERSION}
S="${WORKDIR}/${MY_P}"

pkg_setup() {
	ebegin "Package setup"
	eend 0
}

src_unpack() {
	mkdir ${S}
}

src_install() {
	exeinto /usr/local/bin
	doexe ${FILESDIR}/start-cf.sh

	exeinto /usr/bin
	doexe ${FILESDIR}/cold-fusion

	insinto /usr/share/xsessions
	doins ${FILESDIR}/coldfusion.desktop

	# install all wm settings for specific user
	# awful cheat to detemine current user (in who's dir will configs be dropped)
	WM_SUDO_USER=$(env|grep SUDO_USER|cut -f2 -d=)
	WM_SUDO_UID=$(env|grep SUDO_UID|cut -f2 -d=)
	#WM_SUDO_GUID=$(env|grep SUDO_GUID|cut -f2 d=)

	# set specific options to make files owned by user
	# that installs
	insopts -o ${WM_SUDO_USER} -g ${WM_SUDO_USER} -m0644
	diropts -o ${WM_SUDO_USER} -g ${WM_SUDO_USER} -m0755
	exeopts -o ${WM_SUDO_USER} -g ${WM_SUDO_USER} -m0755

	dodir /home/${WM_SUDO_USER}/.coldfusion
	dodir /home/${WM_SUDO_USER}/.coldfusion/config
	dodir /home/${WM_SUDO_USER}/.coldfusion/status

	# put config file for cf compiz
	insinto /home/${WM_SUDO_USER}/.coldfusion/config
	newins ${FILESDIR}/CompizColdFusionSettings.ini compiz.ini
	newins ${FILESDIR}/gtk.conf gtk.conf

	# put a flag to indicate a first start after installation
	#insinto /home/${WM_SUDO_USER}/.coldfusion/status
}

#pkg_postinstall() {
	#WM_SUDO_USER=$(env|grep SUDO_USER|cut -f2 -d=)
	# make current user own settings file
	#chown -r ${WM_SUDO_USER}:${WM_SUDO_USER} /home/${WM_SUDO_USER}/.coldfusion
	#chown ${WM_SUDO_USER}:${WM_SUDO_USER} /home/${WM_SUDO_USER}/.coldfusion/config/compiz.ini
	#chown ${WM_SUDO_USER}:${WM_SUDO_USER} /home/${WM_SUDO_USER}/.coldfusion/config/gtk.conf
	#chown ${WM_SUDO_USER}:${WM_SUDO_USER} /home/${WM_SUDO_USER}/.coldfusion/status
#}