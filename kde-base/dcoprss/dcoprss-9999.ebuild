# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdenetwork
KMCOPYLIB="librss librss"
KMEXTRACTONLY="librss"
inherit kde-meta eutils
DESCRIPTION="KDE: RSS server and client for DCOP"
IUSE="kdehiddenvisibility"

DEPEND="=kde-base/librss-${PV}:${SLOT}"
