# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdiff3/kdiff3-0.9.92-r1.ebuild,v 1.2 2008/06/21 14:05:05 mr_bones_ Exp $

EAPI=2
KMNAME=kdesdk
ARTS_REQUIRED="never"
inherit kde-meta
DESCRIPTION="[GIT] KDE-based frontend to diff3"
HOMEPAGE="http://kdiff3.sourceforge.net/"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

RDEPEND="sys-apps/diffutils"

need-kde 9999

# src_compile(){
# 	rm "${S}"/configure
# 	kde_src_compile
# }

src_compile() {
	kde_src_compile make
}
