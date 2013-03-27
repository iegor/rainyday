# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdenetwork
KMCOPYLIB="librss librss"
KMEXTRACTONLY="librss"
inherit kde-meta eutils
DESCRIPTION="[GIT] kicker plugin: rss news ticker"
IUSE="kdehiddenvisibility"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="=kde-base/librss-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
