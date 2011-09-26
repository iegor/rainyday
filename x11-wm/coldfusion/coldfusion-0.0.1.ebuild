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
IUSE="docky gnome-do bbrun cairo-dock extras gnome-systools decorations pulseaudio"
FEATURES="sandbox collision-protect strict"

CATEGORY="x11-wm"

MERGE_TYPE="binary"

DEPEND="
	=x11-wm/compiz-0.8.6-r3
	=x11-plugins/compiz-plugins-main-0.8.6-r1
	=x11-apps/ccsm-0.8.4-r1

	extras? ( =x11-plugins/compiz-plugins-extra-0.8.6-r1
		docky? ( gnome-extra/docky )
		decorations? ( x11-wm/emerald )
		gnome-do? ( gnome-extra/gnome-do )
        	!gnome-do? (
                	   bbrun? ( x11-misc/bbrun ) ) )

	gnome-extra/gnome-system-monitor
	app-admin/gnome-system-tools
	x11-misc/xcalendar
	x11-misc/trayer
	pulseaudio? ( media-sound/pavucontrol )
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

	exeinto /usr/local/bin
	doexe ${FILESDIR}/start-cf.sh

	exeinto /usr/bin
	doexe ${FILESDIR}/cold-fusion

	insinto /usr/share/xsessions
	doins ${FILESDIR}/coldfusion.desktop

	# put config file for cf compiz
	insinto /home/${WM_SUDO_USER}/.config/compiz/compizconfig
	newins ${FILESDIR}/CompizColdFusionSettings.ini Default.ini
	# make current user own settings file
	chmod ${WM_SUDO_USER}:${WM_SUDO_USER} ${D}/home/${WM_SUDO_USER}/.config/compiz/compizconfig/Default.ini
}
