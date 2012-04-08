# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdnssd-avahi/kdnssd-avahi-0.1.2-r1.ebuild,v 1.6 2009/10/12 07:09:16 abcd Exp $

EAPI=2

inherit kde

DESCRIPTION="DNS Service Discovery kioslave using Avahi (rather than mDNSResponder)"
HOMEPAGE="http://wiki.kde.org/tiki-index.php?page=Zeroconf+in+KDE"
SRC_URI="http://helios.et.put.poznan.pl/~jstachow/pub/${PN}_${PV}.orig.tar.gz
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="net-dns/avahi[qt3,dbus]"
DEPEND="${RDEPEND}"

need-kde 3.5

src_compile() {
	emake -C "${S}/${PN}" mocs || die "make mocs failed"
	kde_src_compile make
}
