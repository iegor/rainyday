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
IUSE="docky extras decorations pulseaudio filemanager_nautilus filemanager_pcman filebrowser_mfb"
FEATURES="sandbox collision-protect strict"

CATEGORY="x11-wm"

MERGE_TYPE="binary"

DEPEND="
	=x11-wm/compiz-0.8.6-r3
	=x11-plugins/compiz-plugins-main-0.8.6-r1
	=x11-apps/ccsm-0.8.4-r1

	extras? ( =x11-plugins/compiz-plugins-extra-0.8.6-r1
		docky? ( gnome-extra/docky )
		decorations? ( x11-wm/emerald ) )

	>=app-admin/gkrellm-2.3.5
	>=x11-themes/gkrellm-themes-0.1
	>=x11-plugins/gkrellm-bluez-0.2-r1
	>=x11-plugins/gkrellm-trayicons-1.03
	>=x11-plugins/gkrellm-xkb-1.05
	>=x11-plugins/gkrellmlaunch-0.5
	gnome-extra/gnome-system-monitor
	x11-misc/xcalendar
	x11-misc/trayer
	pulseaudio? ( media-sound/pavucontrol )

	filemanager_nautilus? ( >=gnome-base/nautilus-2.32.2.1-r1 )
	filemanager_pcman? ( >=x11-misc/pcmanfm-0.9.9 )
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
	# awful cheat to detemine current user (in who's dir will configs be dropped)
	WM_SUDO_USER=$(env|grep SUDO_USER|cut -f2 -d=)

	dodir /home/${WM_SUDO_USER}/.coldfusion
	dodir /home/${WM_SUDO_USER}/.coldfusion/config
	dodir /home/${WM_SUDO_USER}/.coldfusion/status

	exeinto /usr/local/bin
	doexe ${FILESDIR}/start-cf.sh

	exeinto /usr/bin
	doexe ${FILESDIR}/cold-fusion

	insinto /usr/share/xsessions
	doins ${FILESDIR}/coldfusion.desktop

	# put config file for cf compiz
	insinto /home/${WM_SUDO_USER}/.coldfusion/config	#insinto /home/${WM_SUDO_USER}/.config/compiz/compizconfig
	newins ${FILESDIR}/CompizColdFusionSettings.ini compiz.ini	#newins ${FILESDIR}/CompizColdFusionSettings.ini Default.ini
	newins ${FILESDIR}/gtk.conf gtk.conf
}

pkg_postinstall() {
	WM_SUDO_USER=$(env|grep SUDO_USER|cut -f2 -d=)

	# make current user own settings file
	chmod -r ${WM_SUDO_USER}:${WM_SUDO_USER} /home/${WM_SUDO_USER}/.coldfusion
	#chmod ${WM_SUDO_USER}:${WM_SUDO_USER} /home/${WM_SUDO_USER}/.coldfusion/config/compiz.ini
	#chmod ${WM_SUDO_USER}:${WM_SUDO_USER} /home/${WM_SUDO_USER}/.coldfusion/config/gtk.conf
}