# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdesdk
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE Frontend for Cachegrind"
IUSE="kdehiddenvisibility"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

#DEPEND="!alpha? ( !sparc? ( !x86-fbsd? ( >=dev-util/valgrind-3.2.0 ) ) )"
RDEPEND="${DEPEND}
	media-gfx/graphviz"

pkg_postinst() {
	kde_pkg_postinst

	echo
	elog "To make full use of ${PN} you should emerge >=dev-util/valgrind-3.2.0 and/or"
	elog "dev-util/oprofile."
	echo
}
