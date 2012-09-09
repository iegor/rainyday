# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="1"
KMNAME=kdelibs
ARTS_REQUIRED="never"

inherit kde-meta eutils

DESCRIPTION="A KDE style inspired by equinox gtk+ style."
# SRC_URI="http://www.usermode.org/code/${P}.tar.bz2"
HOMEPAGE="https://github.com/iegor/kdelibs"
LICENSE=""

SLOT="0"
KEYWORDS="alpha ~amd64 ia64 -ppc sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="=kde-base/kwin-3.5*"
RDEPEND=""

KMEXTRA="kstyles/equinox kde.pot libltdl kdefx"
# KMCOPYLIB="libltdl"

need-kde 3.2
