# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdemultimedia
KMCOPYLIB="libkcddb libkcddb"
KMCOMPILEONLY="libkcddb"
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE CD player"
IUSE=""

DEPEND="x11-libs/libXext
	=kde-base/libkcddb-${PV}:${SLOT}"

src_compile() {
	DO_NOT_COMPILE=libkcddb kde-meta_src_compile myconf configure
	cd "$S"/libkcddb && emake configbase.h
	cd "$S"/libkcddb && emake cdinfodialogbase.h
	DO_NOT_COMPILE=libkcddb kde-meta_src_compile make
}
