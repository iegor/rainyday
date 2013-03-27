# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils multilib toolchain-funcs git-2

DESCRIPTION="Small dynamic tiling window manager for X11"
HOMEPAGE="http://www.spectrwm.org"
#SRC_URI="http://opensource.conformal.com/snapshots/${PN}/${P}.tgz"
EGIT_REPO_URI="git://opensource.conformal.com/spectrwm.git"
EGIT_SOURCEDIR="${WORKDIR}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-misc/dmenu"
DEPEND="${DEPEND}
	x11-libs/libX11
	x11-libs/libXrandr
	x11-libs/libXtst"

S=${WORKDIR}/linux

src_prepare() {
	epatch "${FILESDIR}"/spectrwm-9999-makefile.patch
	tc-export CC
}

src_install() {
	emake PREFIX="${D}"usr LIBDIR="${D}usr/$(get_libdir)"  install || die

	# Set session
	insinto /usr/share/xsessions
	doins ${FILESDIR}/spectrwm.desktop
	doins ${FILESDIR}/spectrwm-kde.desktop
	doins ${FILESDIR}/spectrwm-gnome.desktop

	# Set executable script
	exeinto /usr/local/bin
	doexe ${FILESDIR}/spectrwm.sh
	doexe ${FILESDIR}/spectrwm-kde.sh
	doexe ${FILESDIR}/spectrwm-gnome.sh
}
