# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kworldclock/kworldclock-3.5.10.ebuild,v 1.7 2009/07/12 09:47:20 armin76 Exp $

EAPI=2
KMNAME=kdetoys
# kworldclock is called kworldwatch in the tarball, doc/ is not
KMMODULE=kworldwatch
KMNODOCS=true
KMEXTRA="doc/kworldclock"
KDE_DOWNLOAD_SOURCE="git"
inherit kde-meta
DESCRIPTION="[GIT] KDE program that displays the part of the Earth lit up by the Sun"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND=""