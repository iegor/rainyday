# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdegames
KMEXTRACTONLY=libkdegames
KMCOPYLIB="libkdegames libkdegames"
inherit kde-meta
DESCRIPTION="[GIT] A Backgammon program for KDE"
IUSE="kdehiddenvisibility"

DEPEND="=kde-base/libkdegames-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
