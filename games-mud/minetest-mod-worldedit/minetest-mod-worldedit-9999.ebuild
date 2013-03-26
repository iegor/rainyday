# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit games git-2

DESCRIPTION="Minetest mod for editing minetest world"
HOMEPAGE="git://github.com/Uberi/MineTest-WorldEdit"
SRC_URI=""

EGIT_REPO_URI="git://github.com/Uberi/MineTest-WorldEdit.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
games-mud/minetest
"
RDEPEND="${DEPEND}"

src_install() {
	S=${WORKDIR}/${P}
#	insinto /usr/share/games/minetest/mods/worldedit
#	doins ${S}/worldedit
#	for fl in ${S}/worldedit/*; do
#		doins "${fl}" && einfo copy "${fl}"
#	done

#	insinto /usr/share/games/minetest/mods/worldedit_commands
#	for fl in ${S}/worldedit_commands/*; do
#		doins "${fl}" && einfo copy "${fl}"
#	done

	mkdir -p "${D}/usr/share/games/minetest/mods/minetest/worldedit/"
	cp -R "${S}/worldedit/" "${D}/usr/share/games/minetest/mods/minetest/"
	mkdir -p "${D}/usr/share/games/minetest/mods/minetest/worldedit_commands/"
	cp -R "${S}/worldedit_commands/"
	"${D}/usr/share/games/minetest/mods/minetest/"
}
