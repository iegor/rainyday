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
DEPEND="dev-libs/openssl"

src_compile() {
	myconf="--with-ssl"
	kde_src_compile
}
