# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klaptopdaemon/klaptopdaemon-3.5.10.ebuild,v 1.7 2009/07/12 10:33:33 armin76 Exp $

EAPI=2
KMNAME=kdeutils
KDE_DOWNLOAD_SOURCE="git"
inherit kde-meta eutils
DESCRIPTION="[GIT] KLaptopdaemon - KDE battery monitoring and management for laptops."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility xscreensaver"

RDEPEND="x11-libs/libXtst
	xscreensaver? ( x11-libs/libXScrnSaver )"
DEPEND="${RDEPEND}
	virtual/os-headers"

src_compile() {
	myconf="${myconf} $(use_with xscreensaver)"
	kde_src_compile
}