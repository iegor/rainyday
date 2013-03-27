# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdegames
KMEXTRACTONLY=libkdegames
KMCOPYLIB="libkdegames libkdegames"
RESTRICT="test"
inherit kde-meta
DESCRIPTION="[GIT] KMines is a classic mine sweeper game"
IUSE="kdehiddenvisibility"

DEPEND="=kde-base/libkdegames-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
