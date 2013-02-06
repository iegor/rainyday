# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdesdk
inherit kde-meta eutils
DESCRIPTION="[GIT] Cervisia - A KDE CVS frontend"
HOMEPAGE="http://cervisia.kde.org"
IUSE="kdehiddenvisibility"

RDEPEND="${RDEPEND}
	dev-vcs/cvs"
