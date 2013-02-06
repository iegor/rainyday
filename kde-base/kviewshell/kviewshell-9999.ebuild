# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdegraphics
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE: Generic framework for viewer applications"
IUSE=""

DEPEND=""
RDEPEND="|| ( =kde-base/kdebase-kioslaves-${PV}:${SLOT} =kde-base/kdebase-${PV}:${SLOT} )"
