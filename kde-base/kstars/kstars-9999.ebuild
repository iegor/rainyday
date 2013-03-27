# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdeedu
KMEXTRACTONLY="libkdeedu/extdate
	libkdeedu/kdeeduplot
	libkdeedu/kdeeduui"
KMCOPYLIB="libextdate libkdeedu/extdate
		libkdeeduplot libkdeedu/kdeeduplot
		libkdeeduui libkdeedu/kdeeduui"
inherit kde-meta
DESCRIPTION="[GIT] KDE Desktop Planetarium"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="=kde-base/libkdeedu-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

src_unpack () {
	kde-meta_src_unpack
	cd "${S}"
}
