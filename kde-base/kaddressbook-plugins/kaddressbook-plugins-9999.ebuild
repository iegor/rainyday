# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA=kaddressbook-plugins/
inherit kde-meta
DESCRIPTION="[GIT] Plugins for KAB"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="|| ( =kde-base/kaddressbook-${PV}:${SLOT} =kde-base/kdepim-${PV}:${SLOT} )"
RDEPEND="${DEPEND}"
