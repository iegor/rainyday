# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdemultimedia
KMMODULE=kioslave
KMCOPYLIB="libkcddb libkcddb"
KMEXTRACTONLY="akode/configure.in.in"
KMCOMPILEONLY="
	kscd
	kscd/libwm
	libkcddb"
inherit kde-meta eutils
DESCRIPTION="[GIT] kioslaves from kdemultimedia package"
IUSE="encode flac mp3 vorbis"

DEPEND="=kde-base/libkcddb-${PV}:${SLOT}
	media-sound/cdparanoia
	media-libs/taglib
	encode? ( vorbis? ( media-libs/libvorbis )
			flac? ( >=media-libs/flac-1.1.2 ) )"
RDEPEND="${DEPEND}
	encode? ( mp3? ( media-sound/lame ) )"

src_compile() {
	myconf="--with-cdparanoia --enable-cdparanoia"
	if use encode; then
		myconf="$myconf $(use_with vorbis) $(use_with flac)"
	else
		myconf="$myconf --without-vorbis --without-flac"
	fi

	DO_NOT_COMPILE="libkcddb kscd" kde-meta_src_compile myconf configure
	cd "${S}"/libkcddb && emake configbase.h cdinfodialogbase.h

	# Library deps seems not to be built as they should :/
	cd "${S}"/kscd/libwm/audio && emake libworkmanaudio.la && \
	cd "${S}"/kscd/libwm && emake libworkman.la && \
	cd "${S}"/kscd && emake libkcompactdisc.la || \
		die "failed to make prerequisite libraries."

	DO_NOT_COMPILE="libkcddb kscd" kde-meta_src_compile make
}
