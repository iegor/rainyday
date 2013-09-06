# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdeaddons
KMNODOCS=true
inherit kde-meta
DESCRIPTION="[GIT] Various plugins for Konqueror."
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="|| ( =kde-base/konqueror-${PV}:${SLOT} =kde-base/kdebase-${PV}:${SLOT} )
	!kde-misc/metabar"
RDEPEND="${DEPEND}
=kde-base/kdeaddons-docs-konq-plugins-${PV}:${SLOT}"

# Don't install the akregator plugin, since it depends on akregator, which is
# a heavy dep.
KMEXTRACTONLY="konq-plugins/akregator"
