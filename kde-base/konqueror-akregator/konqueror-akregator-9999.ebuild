# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="konq-plugins/akregator"
inherit kde-meta
DESCRIPTION="[GIT] konqueror's akregator plugin"
IUSE=""

DEPEND="|| ( =kde-base/konqueror-${PV}:${SLOT} =kde-base/kdebase-${PV}:${SLOT} )"
RDEPEND="${DEPEND}
=kde-base/kdeaddons-docs-konq-plugins-${PV}:${SLOT}
|| ( =kde-base/akregator-${PV}:${SLOT} =kde-base/kdepim-${PV}:${SLOT} )"
