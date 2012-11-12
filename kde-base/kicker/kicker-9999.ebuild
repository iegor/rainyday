# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kicker/kicker-3.5.10-r1.ebuild,v 1.7 2009/07/08 14:06:56 alexxy Exp $

EAPI=2
KMNAME=kdebase
KMCOPYLIB="libkonq libkonq"
KMEXTRACTONLY="libkonq
	kdm/kfrontend/themer/"
KMCOMPILEONLY="kdmlib/"
KDE_DOWNLOAD_SOURCE="git"
inherit kde-meta eutils
DESCRIPTION="[GIT] Kicker is the KDE application starter panel, also capable of some useful applets and extensions."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility xcomposite"

DEPEND="=kde-base/libkonq-${PV}:${SLOT}
	=kde-base/kdebase-data-${PV}:${SLOT}
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXtst
	xcomposite? ( x11-libs/libXcomposite )"
RDEPEND="${DEPEND}
	=kde-base/kmenuedit-${PV}:${SLOT}"

src_compile() {
	myconf="$myconf $(use_with xcomposite composite)"
	kde-meta_src_compile
}
