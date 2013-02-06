# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdebase
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE tool looking for well-known apps in your path and creates entries for them in the KDE menu"
IUSE="kdehiddenvisibility"

RDEPEND="=kde-base/kicker-${PV}:${SLOT}"
