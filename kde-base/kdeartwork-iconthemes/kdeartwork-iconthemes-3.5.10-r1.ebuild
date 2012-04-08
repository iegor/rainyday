# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-iconthemes/kdeartwork-iconthemes-3.5.10.ebuild,v 1.7 2009/07/12 10:09:15 armin76 Exp $

RESTRICT="binchecks strip"

KMMODULE=IconThemes
KMNAME=kdeartwork
EAPI="1"
inherit kde-meta

DESCRIPTION="Icon themes for kde"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=""

src_unpack() {
	kde-meta_src_unpack

	# Add icons tab_move_left and tab_move_right according to upstream branch.
	# See http://websvn.kde.org/?view=revision&revision=889208
	for dir in left right; do
		for size in 16 22 32; do
			cp ${FILESDIR}/tab_move_${dir}_${size}-r889208.png \
				"${S}/IconThemes/kdeclassic/${size}x${size}/actions/tab_move_${dir}.png" \
				|| die "Error copying ${size}x${size}/actions/tab_move_${dir}.png"
		done
	done
}
