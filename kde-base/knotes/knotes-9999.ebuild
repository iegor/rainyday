# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdepim
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE Notes"
IUSE=""

DEPEND="=kde-base/libkcal-${PV}:${SLOT}
=kde-base/libkdepim-${PV}:${SLOT}
=kde-base/kontact-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMCOPYLIB="
	libkcal libkcal
	libkdepim libkdepim
	libkpinterfaces kontact/interfaces"
KMEXTRACTONLY="
	libkcal/
	libkdepim/
	kontact/interfaces"
KMEXTRA="kontact/plugins/knotes" # We add here the kontact's plugin instead of compiling it with kontact because it needs a lot of this programs deps.
