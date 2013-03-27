# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdenetwork
KMMODULE=wifi
KMEXTRA="doc/kwifimanager"
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE wifi (wireless network) gui"
IUSE="kdehiddenvisibility"

DEPEND="net-wireless/wireless-tools"
RDEPEND="${DEPEND}"
