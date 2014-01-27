# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/minetest_common/minetest_common-0.4.6.ebuild,v 1.3 2013/10/27 10:35:48 hasufell Exp $

EAPI=5
inherit vcs-snapshot games git-2

DESCRIPTION="Common game content mods, for use in various Minetest games"
HOMEPAGE="https://github.com/minetest/common"
SRC_URI="git://github.com/minetest/common.git"

LICENSE="GPL-2 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

RDEPEND=">=games-action/minetest-${PV}[-dedicated]"

src_unpack() {
	vcs-snapshot_src_unpack
}

src_install() {
	insinto "${GAMES_DATADIR}"/minetest/games/common
	doins -r mods

	prepgamesdirs
}
