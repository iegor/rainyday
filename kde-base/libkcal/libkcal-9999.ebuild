# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdepim
KMCOPYLIB="libktnef ktnef/lib
	libkmime libkmime"
KMEXTRACTONLY="libkdepim/email.h
	libkmime/kmime_util.h"
KMCOMPILEONLY="libemailfunctions/"
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE kcal library for KOrganizer etc"
IUSE=""

DEPEND="=kde-base/ktnef-${PV}:${SLOT}
	=kde-base/libkmime-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

src_unpack() {
	kde-meta_src_unpack
	sed -e "s:SUBDIRS = libical versit tests:SUBDIRS = libical versit:" -i libkcal/Makefile.am
}
