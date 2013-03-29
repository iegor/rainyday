# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="This installs some useful day to day scripts into /usr/bin/scripts"
HOMEPAGE="github.com/iegor/rainyday"
SRC_URI=""
FEATURES="sandbox collision-protect strict"

CATEGORY="sys-utils"

LICENSE="BEERWARE"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

# S=${FILESDIR}
#src_install() {
pkg_preinst() {
	mkdir -p /usr/bin/scripts
	exeinto /usr/bin/scripts
	doexe ${FILESDIR}/urxvt_user
	doexe ${FILESDIR}/urxvt_root
	doexe ${FILESDIR}/xterm_user
	doexe ${FILESDIR}/xterm_root
	doexe ${FILESDIR}/eterm_user
	doexe ${FILESDIR}/eterm_root
	doexe ${FILESDIR}/gterm_user
	doexe ${FILESDIR}/gterm_root
	doexe ${FILESDIR}/set_cpu_scaling
}

#pkg_postinst() {
#}
