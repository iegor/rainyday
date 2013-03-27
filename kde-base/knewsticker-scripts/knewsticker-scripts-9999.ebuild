# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdeaddons
inherit kde-meta
DESCRIPTION="[GIT] Kicker applet - RSS news ticker"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="|| ( =kde-base/knewsticker-${PV}:${SLOT} =kde-base/kdenetwork-${PV}:${SLOT} )"
RDEPEND="${DEPEND}"
