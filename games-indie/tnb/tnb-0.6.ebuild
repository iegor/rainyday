# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Absolutely gorgious free indie game. Episode 0 'Up That Mountain'"
HOMEPAGE="http://www.tinyandbig.com/games/upthatmountain/"
SRC_URI="http://www.tinyandbig.com/downloads/tinyandbig_upthatmountain_linux-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="
dev-lang/lua
media-libs/libtxc_dxtn
media-libs/libsdl
media-libs/openal
"
DEPEND=""

PREFIX="/opt"
DESTDIR="/opt"
