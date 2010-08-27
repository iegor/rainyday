# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/knetworkmanager/knetworkmanager-0.2.2_p20080528.ebuild,v 1.1 2008/06/24 17:55:41 rbu Exp $

inherit kde eutils

DESCRIPTION="A KDE frontend for NetworkManager"
HOMEPAGE="http://en.opensuse.org/Projects/KNetworkManager"
LICENSE="GPL-2"
SRC_URI="http://www.thel.ro/kde-sunset/${P}.tar.bz2"
KEYWORDS="~x86"

IUSE="cisco openvpn pptp dialup"

need-kde 3.5

SLOT="0"

DEPEND="net-misc/networkmanager
	=kde-base/kdelibs-3.5*
	dev-libs/dbus-qt3-old:0.9
	sys-apps/hal
	net-wireless/wireless-tools
	>=dev-libs/libnl-1.1
	cisco?   ( <net-misc/networkmanager-vpnc-0.7.0 )
	openvpn? ( <net-misc/networkmanager-openvpn-0.3.3 )
	pptp?    ( <net-misc/networkmanager-pptp-0.7.0 )
	dialup? ( =kde-base/kppp-3.5* )"

RDEPEND="${DEPEND}"
DEPEND="${DEPEND}
	>=sys-kernel/linux-headers-2.6.19
	sys-apps/util-linux"

S="${WORKDIR}/${PN}"

pkg_setup() {
	kde_pkg_setup
}

src_unpack() {
	kde_src_unpack
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.7-dbus_access.patch
	epatch "${FILESDIR}"/${PN}-0.7-no_blank_psk.patch
	epatch "${FILESDIR}"/${PN}-0.7-configure-check-for-nm.patch
	epatch "${FILESDIR}"/${PN}-0.7-uuid_fix.patch
}

src_compile() {
	set-kdedir
	export PREFIX="${KDEDIR}"
	local myconf="$(use_with cisco vpnc) \
		$(use_with openvpn) \
		$(use_with pptp) \
		$(use_with dialup) \
		--with-distro=gentoo --disable-rpath"
	kde_src_compile
}

src_install() {
	kde_src_install

	# kde.eclass sets sysconfdir too weird for us, delete conf from there and reinstall to /etc
	set-kdedir
	rm -rf "${D}/${KDEDIR}/etc"
	insinto /etc/dbus-1/system.d/
	doins ${PN}-0.7/knetworkmanager.conf
}
