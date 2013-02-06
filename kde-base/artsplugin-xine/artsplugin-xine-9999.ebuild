# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdemultimedia
KMMODULE=xine_artsplugin
inherit kde-meta eutils
DESCRIPTION="[GIT] arts xine plugin"
IUSE=""

DEPEND="x11-libs/libXext >=media-libs/xine-lib-1.0"
