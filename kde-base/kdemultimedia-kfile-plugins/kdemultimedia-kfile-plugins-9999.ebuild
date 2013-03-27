# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdemultimedia
KMMODULE=kfile-plugins
inherit kde-meta eutils
DESCRIPTION="kfile plugins from kdemultimedia package"
IUSE="vorbis theora"
DEPEND="media-libs/taglib
	vorbis? ( media-libs/libvorbis )
	theora? (
		media-libs/libvorbis
		media-libs/libtheora )"

src_compile() {
	myconf="$myconf $(use_with vorbis)"
	kde-meta_src_compile
}
