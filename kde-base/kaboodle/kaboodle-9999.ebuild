# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdemultimedia
KMEXTRACTONLY="arts/"
inherit kde-meta eutils
DESCRIPTION="[GIT] The Lean KDE Media Player"
IUSE=""

# OLDRDEPEND="~kde-base/kdemultimedia-arts-${PV}"
RDEPEND="
=kde-base/kdemultimedia-arts-${PV}:${SLOT}
"
