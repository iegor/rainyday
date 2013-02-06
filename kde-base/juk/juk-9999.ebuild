# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdemultimedia
KMEXTRACTONLY="arts/configure.in.in"
inherit kde-meta eutils
DESCRIPTION="[GIT] Jukebox and music manager for KDE."
IUSE="akode gstreamer"

RDEPEND="media-libs/taglib
	gstreamer? ( media-libs/gst-plugins-base:0.10 )
	akode? ( media-libs/akode )
	!arts? ( !gstreamer? ( media-libs/akode ) )"
DEPEND="${RDEPEND}"
PDEPEND="gstreamer? ( media-plugins/gst-plugins-meta:0.10 )"

pkg_setup() {
	kde_pkg_setup
	if ! use arts && ! use gstreamer && ! use akode ; then
		ewarn "No audio backend chosen. Defaulting to media-libs/akode."
	fi
}

src_compile() {
	local myconf="$(use_with gstreamer) --without-musicbrainz"

	if ! use arts && ! use gstreamer ; then
		myconf="${myconf} --with-akode"
	else
		if ! use akode ; then
			# work around broken configure
			export include_akode_ffmpeg_FALSE='#'
			export include_akode_mpc_FALSE='#'
			export include_akode_mpeg_FALSE='#'
			export include_akode_xiph_FALSE='#'
		fi
		myconf="${myconf} $(use_with akode)"
	fi

	kde-meta_src_compile
}
