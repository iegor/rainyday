# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="This installs some useful day to day scripts into /usr/local/bin"
HOMEPAGE="http://github.com/iegor/rainyday/sys-utils/useful-scripts"
SRC_URI=""
FEATURES="sandbox collision-protect strict"

LICENSE="GPL-V2"
SLOT=0
KEYWORDS="~x86"
IUSE="gnome kde rxvt xterm eterm unicode"

RDEPEND=""
DEPEND="
	gnome? ( x11-terms/gnome-terminal )
	kde? ( kde-base/konsole )
	rxvt? (
		unicode? ( x11-terms/rxvt-unicode )
		!unicode? ( x11-terms/rxvt )
	)
	eterm? ( x11-terms/eterm )
	xterm? ( x11-terms/xterm )
"

# S=${FILESDIR}
#src_install() {
pkg_preinst() {
	exeinto '/usr/local/bin'
	if use rxvt; then
		doexe ${FILESDIR}/urxvt_user
		doexe ${FILESDIR}/urxvt_root
	fi

	if use xterm; then
		doexe ${FILESDIR}/xterm_user
		doexe ${FILESDIR}/xterm_root
	fi

	if use eterm; then
		doexe ${FILESDIR}/eterm_user
		doexe ${FILESDIR}/eterm_root
	fi

	if use gnome; then
		doexe ${FILESDIR}/gterm_user
		doexe ${FILESDIR}/gterm_root
	fi

	doexe ${FILESDIR}/set_cpu_scaling
}

#pkg_postinst() {
#}
