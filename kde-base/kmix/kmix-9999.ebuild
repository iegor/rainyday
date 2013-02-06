# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdemultimedia
inherit kde-meta eutils
DESCRIPTION="aRts mixer gui"
IUSE="alsa"

DEPEND="alsa? ( media-libs/alsa-lib )"
RDEPEND="${DEPEND}"

src_compile() {
	local myconf="$(use_with alsa)"
	kde-meta_src_compile
}
