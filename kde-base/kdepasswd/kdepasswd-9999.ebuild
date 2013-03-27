# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdebase
KMCOPYLIB="libkonq libkonq"
KMNODOCS=true
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE GUI for passwd"
IUSE="kdehiddenvisibility"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="=kde-base/libkonq-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
