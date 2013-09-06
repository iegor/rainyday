# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdesdk
KMMODULE="scripts"
inherit kde-meta
DESCRIPTION="[GIT] Kdesdk Scripts - Some useful scripts for the development of applications"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

src_unpack() {
	kde-meta_src_unpack

	# bug 275069
	sed -rie 's:color(cvs(rc-sample)?|svn)::g' scripts/Makefile.am || die
}
