# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMMODULE=kwin-styles
KMNAME=kdeartwork
inherit kde-meta
DESCRIPTION="[GIT] Window styles for kde"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="|| ( =kde-base/kwin-${PV}:${SLOT} =kde-base/kdebase-${PV}:${SLOT} )"
