# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcheckpass/kcheckpass-3.5.10.ebuild,v 1.8 2009/07/12 09:34:25 armin76 Exp $

EAPI="1"
KMNAME=kdebase

inherit kde-meta eutils flag-o-matic

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-13.tar.bz2"

DESCRIPTION="[GIT] A simple password checker, used by any software in need of user authentication."
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="pam kdehiddenvisibility"
KDE_DOWNLOAD_SOURCE="git"

DEPEND="pam? ( kde-base/kdebase-pam )"
RDEPEND="${DEPEND}"

src_compile() {
	myconf="$(use_with pam)"

	kde-meta_src_compile
}