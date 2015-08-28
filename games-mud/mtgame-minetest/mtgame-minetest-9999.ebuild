# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
EGIT_REPO_URI=${EGIT_REPO_URI:="git://github.com/minetest/minetest_game.git"}
EGIT_BRANCH=${EGIT_BRANCH:=master}
inherit git-support games

DESCRIPTION="Minetest game: The main game for the Minetest game engine"
HOMEPAGE="http://github.com/minetest/minetest_game"
LICENSE="GPL-2 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

RDEPEND="~games-mud/minetest-${PV}[-dedicated]"
DEPEND="${RDEPEND}"

src_unpack() {
	git-support_src_unpack
}

src_install() {
	insinto "${GAMES_DATADIR}"/minetest/games/minetest_game
	doins -r mods menu
	doins game.conf minetest.conf

	# docinto /usr/share/doc/minetest_game
	dodoc README.txt game_api.txt minetest.conf.example

	prepgamesdirs
}
