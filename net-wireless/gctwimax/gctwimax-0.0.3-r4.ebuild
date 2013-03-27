# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="4"

inherit eutils

DESCRIPTION="This is a reverse-engineered driver for mobile WiMAX (802.16e) devices/n
based on GCT Semiconductor GDM7213 & GDM7205 chip.
based on madwimax driver"

HOMEPAGE="http://code.google.com/p/gctwimax/"
FEATURES="sandbox collision-protect strict"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="dbus"
SRC_URI="http://gctwimax.googlecode.com/files/gctwimax-0.0.3rc4.tar.gz"

# PATCHES="${FILESDIR}/gctwimax-0.0.3rc4_libusb_context_fix.patch"

RDEPEND="net-wireless/wpa_supplicant[eap-sim,wimax]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-0.0.3rc4"

src_prepare() {
# 	mkdir -p ${S}
# 	base_src_unpack
# 	cd ${S}
# 	einfo "S: $S"
# 	einfo "pwd: $(pwd)"
	epatch "${FILESDIR}/gctwimax-0.0.3rc4_libusb_context_fix.patch"
	epatch "${FILESDIR}/makefile.patch"

	if use dbus ; then
		CFLAGS="${CFLAGS} -DWITH_DBUS"
	fi
}

# src_install() {
#     emake DESTDIR="${D}" install || die
# 		einstall

#     dodoc FAQ NEWS README || die
#     dohtml EXTENDING.html ctags.html
# }

pkg_postinst() {
	einfo "To get help."
	einfo "	$ sudo gctwimax -h"
	einfo "simple usage:"
	einfo "	$ gctwimax --cfg-file=/usr/share/gctwimax/gctwimax.conf"
	einfo "If the driver did not get IP Address automatically enter:\n\t$ dhclient wimaxX"
	einfo ""
	einfo "Also, please visit our support forum:"
	einfo "http://ualinux.com/index.php/forum/10/67-freshtel---sagem-fst-9520-seowon-swu-3220a"
	einfo "Code, fixes and ideas from:"
	einfo "-	fanboy"
	einfo "-	Gennady Knyazkin (GennadyX) <gennadyx@gmail.com>"
	einfo "-	Macpaul Lin	<macpaul@gmail.com>"
	einfo "Verifiers:"
	einfo "-	Alexander Grohochinsky"
}

pkg_info() {
	einfo "${DESCRIPTION}"
	einfo "Code, fixes and ideas from:"
	einfo "-	fanboy"
	einfo "-	Gennady Knyazkin (GennadyX) <gennadyx@gmail.com>"
	einfo "-	Macpaul Lin	<macpaul@gmail.com>"
	einfo "Verifiers:"
	einfo "-	Alexander Grohochinsky"
}