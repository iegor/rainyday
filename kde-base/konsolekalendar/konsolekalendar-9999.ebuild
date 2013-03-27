# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdepim
inherit kde-meta eutils
DESCRIPTION="[GIT] A command line interface to KDE calendars"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="
=kde-base/libkcal-${PV}:${SLOT}
=kde-base/libkdepim-${PV}:${SLOT}
"
RDEPEND="
${DEPEND}
"

KMCOPYLIB="
libkcal libkcal
libkdepim libkdepim
"
KMEXTRACTONLY="
libkdepim/
"
KMCOMPILEONLY="
libkcal
"

src_compile() {
# 	export DO_NOT_COMPILE=libkcal
	sed -i "/libkcal/d" "${S}/subdirs"
# 	kde-meta_src_compile myconf configure
	cd "${S}"/libkcal; emake htmlexportsettings.h
	kde-meta_src_compile make
}
