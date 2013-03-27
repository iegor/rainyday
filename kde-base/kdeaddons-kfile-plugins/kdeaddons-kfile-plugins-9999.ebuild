# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kfile-plugins/"
inherit kde-meta
DESCRIPTION="[GIT] kdeaddons kfile plugins"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="dev-libs/openssl"

src_compile() {
	myconf="--with-ssl"
	kde_src_compile
}
