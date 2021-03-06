# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kscd/kscd-3.5.10.ebuild,v 1.7 2009/07/12 12:03:23 armin76 Exp $
EAPI="1"
KMNAME=kdemultimedia
inherit kde-meta eutils

SRC_URI="${SRC_URI}"

DESCRIPTION="KDE CD player"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="x11-libs/libXext
	>=kde-base/libkcddb-${PV}:${SLOT}"

KMCOPYLIB="libkcddb libkcddb"
KMCOMPILEONLY="libkcddb"

PATCHES=( "${FILESDIR}/kscd-3.5.6-alsa-tests.patch"
		"${FILESDIR}/kscd-3.5.6-arts.patch"
		"${FILESDIR}/kscd-3.5-strict-fix.diff" )

src_compile() {
	DO_NOT_COMPILE=libkcddb kde-meta_src_compile myconf configure
	cd "$S"/libkcddb && emake configbase.h
	cd "$S"/libkcddb && emake cdinfodialogbase.h
	DO_NOT_COMPILE=libkcddb kde-meta_src_compile make
}
