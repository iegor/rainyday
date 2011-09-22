# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
VERSION="0.2.2"
DESCRIPTION="The libspnav library is provided as a replacement of the magellan library. It
provides a cleaner, and more orthogonal interface. libspnav supports both the
original X11 protocol for communicating with the driver, and the new
alternative non-X protocol. Programs that choose to use the X11 protocol, are
automatically compatible with either the free spacenavd driver or the official
3dxserv, as if they were using the magellan SDK."
HOMEPAGE="http://spacenav.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/project/spacenav/spacenav%20library%20%28SDK%29/libspnav%200.2.2/libspnav-${PV}.tar.gz"
LICENSE="BEER-WARE"
SLOT="0.2"
KEYWORDS="~amd64 ~x86"
IUSE=""
PROPERTIES="interactive"
FEATURES="sandbox collision-protect strict"

RDEPEND=""
DEPEND="${RDEPEND}"
PDEPEND=""

MY_P="libspnav-${PV}"
S="${WORKDIR}/${MY_P}"

src_install() {
	mkdir /usr/mytestlib
}
