# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdepim
inherit kde-meta eutils
DESCRIPTION="[GIT] A newsreader for KDE"
IUSE=""

KMCOPYLIB="
	libkdepim libkdepim
	libkpinterfaces kontact/interfaces
	libkmime libkmime
	libkpgp libkpgp"
KMEXTRACTONLY="
	libkdepim/
	libkdenetwork/
	kontact/interfaces
	libkmime
	libkpgp
	libemailfunctions"
# We add here the kontact's plugin instead of compiling it with kontact because it needs a lot of this programs deps.
KMEXTRA="kontact/plugins/knode"

DEPEND="=kde-base/libkdepim-${PV}:${SLOT}
=kde-base/libkdenetwork-${PV}:${SLOT}
=kde-base/kontact-${PV}:${SLOT}
=kde-base/libkmime-${PV}:${SLOT}
=kde-base/libkpgp-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
