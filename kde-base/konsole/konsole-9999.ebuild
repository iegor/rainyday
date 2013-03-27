# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdebase
inherit kde-meta eutils
DESCRIPTION="[GIT] X terminal for use with KDE."
IUSE="kdehiddenvisibility"

RDEPEND="x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrender
		x11-libs/libXtst"
DEPEND="${RDEPEND}
		x11-apps/bdftopcf"
# For kcm_konsole module
RDEPEND="${RDEPEND}
	=kde-base/kcontrol-${PV}:${SLOT}"