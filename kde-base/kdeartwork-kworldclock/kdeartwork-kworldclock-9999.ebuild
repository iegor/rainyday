# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMMODULE=kworldclock
KMNAME=kdeartwork
inherit kde-meta
DESCRIPTION="[GIT] kworldclock from kdeartwork"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

RDEPEND="|| ( =kde-base/kworldclock-${PV}:${SLOT} =kde-base/kdetoys-${PV}:${SLOT} )"
