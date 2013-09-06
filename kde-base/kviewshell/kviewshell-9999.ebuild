# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdegraphics
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE: Generic framework for viewer applications"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND=""
RDEPEND="|| ( =kde-base/kdebase-kioslaves-${PV}:${SLOT} =kde-base/kdebase-${PV}:${SLOT} )"
