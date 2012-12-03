# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmix/kmix-3.5.10.ebuild,v 1.8 2009/10/12 05:40:36 abcd Exp $

EAPI=2
KMNAME=kdemultimedia
KDE_DOWNLOAD_SOURCE="git"
inherit kde-meta eutils
DESCRIPTION="aRts mixer gui"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="alsa"

DEPEND="alsa? ( media-libs/alsa-lib )"
RDEPEND="${DEPEND}"

src_compile() {
	local myconf="$(use_with alsa)"
	kde-meta_src_compile
}
