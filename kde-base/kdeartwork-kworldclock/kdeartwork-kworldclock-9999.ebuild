# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMMODULE=kworldclock
KMNAME=kdeartwork
inherit kde-meta
DESCRIPTION="[GIT] kworldclock from kdeartwork"
IUSE=""

RDEPEND="|| ( =kde-base/kworldclock-${PV}:${SLOT} =kde-base/kdetoys-${PV}:${SLOT} )"
