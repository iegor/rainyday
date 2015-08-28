# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
SRC_URI=""
EGIT_REPO_URI=${EGIT_REPO_URI:="git://github.com/HeroOfTheWinds/Sky-Test-game.git"}
EGIT_BRANCH=${EGIT_BRANCH:=master}
inherit git-support games

DESCRIPTION="Minetest game: The Sky game for the Minetest game engine"
HOMEPAGE="https://forum.minetest.net/viewtopic.php?f=11&t=9152"
LICENSE="WTFPL"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND="~games-mud/minetest-${PV}[-dedicated]"
RDEPEND="${DEPEND}"

src_unpack() {
	git-support_src_unpack
}

src_install() {
	insinto "${GAMES_DATADIR}"/minetest/games/skylands
	doins -r menu mods
	doins game.conf minetest.conf

	dodoc README.md

	prepgamesdirs
}
