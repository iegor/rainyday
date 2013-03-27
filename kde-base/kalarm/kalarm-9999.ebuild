# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdepim
inherit kde-meta eutils
DESCRIPTION="[GIT] Personal alarm message, command and email scheduler for KDE"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

KMCOPYLIB="
	libkcal libkcal
	libkdepim libkdepim
	libkmime libkmime
	libkpimidentities libkpimidentities"
KMEXTRACTONLY="
	libkcal/libical
	libkdepim/
	libkdenetwork/
	libkpimidentities/
	libkmime/
	libemailfunctions/"
KMCOMPILEONLY="
	libkcal/libical/src/libical/
	libkcal/libical/src/libicalss/"

DEPEND="=kde-base/libkdepim-${PV}:${SLOT}
=kde-base/libkdenetwork-${PV}:${SLOT}
=kde-base/libkmime-${PV}:${SLOT}
=kde-base/libkpimidentities-${PV}:${SLOT}
=kde-base/libkcal-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

src_compile() {
	export DO_NOT_COMPILE="libkcal" && kde-meta_src_compile myconf configure
	# generate "ical.h"
	cd "${S}/libkcal/libical/src/libical" && make ical.h
	# generate "icalss.h"
	cd "${S}/libkcal/libical/src/libicalss" && make icalss.h

	kde-meta_src_compile make
}
