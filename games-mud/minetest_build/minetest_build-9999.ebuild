# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/minetest_build/minetest_build-0.4.6.ebuild,v 1.3 2013/10/27 10:35:07 hasufell Exp $

EAPI=5
inherit games git-2

DESCRIPTION="Building game for the Minetest game engine"
HOMEPAGE="https://github.com/minetest/build"
EGIT_REPO_URI="git://github.com/minetest/build.git"

LICENSE="GPL-2 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

RDEPEND="=games-mud/minetest-${PV}[-dedicated]"

src_unpack() {
	git-2_src_unpack
}

src_install() {
	insinto "${GAMES_DATADIR}"/minetest/games/build
	doins -r mods
	doins game.conf

	prepgamesdirs
}
