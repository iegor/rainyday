# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdetoys
# kworldclock is called kworldwatch in the tarball, doc/ is not
KMMODULE=kworldwatch
KMNODOCS=true
KMEXTRA="doc/kworldclock"
inherit kde-meta
DESCRIPTION="[GIT] KDE program that displays the part of the Earth lit up by the Sun"
IUSE="kdehiddenvisibility"

DEPEND=""
