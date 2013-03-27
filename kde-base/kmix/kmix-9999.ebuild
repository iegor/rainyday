# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdemultimedia
inherit kde-meta eutils
DESCRIPTION="aRts mixer gui"
IUSE="alsa"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="alsa? ( media-libs/alsa-lib )"
RDEPEND="${DEPEND}"

src_compile() {
	local myconf="$(use_with alsa)"
	kde-meta_src_compile
}
