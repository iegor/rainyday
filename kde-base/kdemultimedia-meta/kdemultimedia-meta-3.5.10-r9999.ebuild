# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-meta/kdemultimedia-meta-3.5.10.ebuild,v 1.8 2009/10/24 22:21:03 ssuominen Exp $

EAPI="1"
inherit kde-functions
DESCRIPTION="kdemultimedia - merge this to pull in all kdemultimedia-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="arts xine"

RDEPEND="arts? ( =kde-base/artsplugin-akode-${PVR}:${SLOT}
		=kde-base/artsplugin-audiofile-${PVR}:${SLOT}
		xine? ( =kde-base/artsplugin-xine-${PVR}:${SLOT} )
		=kde-base/juk-${PVR}:${SLOT}
		=kde-base/kaboodle-${PVR}:${SLOT}
		=kde-base/kaudiocreator-${PVR}:${SLOT}
		=kde-base/kdemultimedia-arts-${PVR}:${SLOT}
		=kde-base/krec-${PVR}:${SLOT} )
	=kde-base/kdemultimedia-kappfinder-data-${PVR}:${SLOT}
	=kde-base/kdemultimedia-kfile-plugins-${PVR}:${SLOT}
	=kde-base/kdemultimedia-kioslaves-${PVR}:${SLOT}
	=kde-base/kmid-${PVR}:${SLOT}
	=kde-base/kmix-${PVR}:${SLOT}
	=kde-base/kscd-${PVR}:${SLOT}
	=kde-base/libkcddb-${PVR}:${SLOT}
	=media-sound/musicman-0.16-${PR}
	=media-sound/amarok-1.4.10_p20090130-${PR}
  =media-video/kaffeine-0.8.8-${PR}"

# Not really useful, these are scheduled for being removed from KDE soon.
#>=kde-base/artsplugin-mpeglib-${PV}:${SLOT}
#>=kde-base/artsplugin-mpg123-${PV}:${SLOT}
#>=kde-base/mpeglib-${PV}:${SLOT}
