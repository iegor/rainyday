# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdepim
KMCOPYLIB="libkdepim libkdepim
	libkpinterfaces kontact/interfaces"
KMEXTRACTONLY="libkdepim
	kontact/interfaces"
KMEXTRA="kontact/plugins/akregator"
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE news feed aggregator."
IUSE="konqueror"
DEPEND="=kde-base/libkdepim-${PV}:${SLOT}
	=kde-base/kontact-${PV}:${SLOT}
	!net-www/akregator"
RDEPEND="${DEPEND}
	konqueror? ( =kde-base/konqueror-akregator-${PV}:${SLOT} )"
