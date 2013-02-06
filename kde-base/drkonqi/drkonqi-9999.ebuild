# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdebase
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE crash handler gives the user feedback if a program crashed"
IUSE="kdehiddenvisibility"

RDEPEND="sys-devel/gdb"
