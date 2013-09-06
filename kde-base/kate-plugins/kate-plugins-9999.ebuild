# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kate"
inherit eutils kde-meta

DESCRIPTION="[GIT] kate plugins and docs"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="|| ( =kde-base/kate-${PV}:${SLOT} =kde-base/kdebase-${PV}:${SLOT} )"
RDEPEND="${DEPEND}"

src_prepare() {
  epatch "${FILESDIR}"/kate-plugins-3.5.10-qstring.patch
}
