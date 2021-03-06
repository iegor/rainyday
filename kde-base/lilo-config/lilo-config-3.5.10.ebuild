# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/lilo-config/lilo-config-3.5.10.ebuild,v 1.5 2009/10/12 05:44:34 abcd Exp $
EAPI="1"
KMNAME=kdeadmin
inherit kde-meta

DESCRIPTION="KDE LiLo kcontrol module"
KEYWORDS="amd64 x86"
IUSE="kdehiddenvisibility"
DEPEND=""

PATCHES=( "$FILESDIR/never-disable.diff" )
