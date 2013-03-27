# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdebase
inherit kde-meta eutils flag-o-matic
DESCRIPTION="[GIT] KDE: gui for su(1)"
IUSE="kdehiddenvisibility"

src_compile() {
	kde-meta_src_compile
}
