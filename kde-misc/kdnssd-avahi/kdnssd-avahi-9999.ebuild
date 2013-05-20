# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=2
KMNAME=kdnssd-avahi
inherit kde

SLOT="3.5"
need-kde 9999

DESCRIPTION="[GIT] DNS Service Discovery kioslave using Avahi (rather than mDNSResponder)"
HOMEPAGE="http://wiki.kde.org/tiki-index.php?page=Zeroconf+in+KDE"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

RDEPEND="net-dns/avahi[qt3]"
DEPEND="${RDEPEND}"

src_compile() {
	emake -C "${S}/${PN}" mocs || die "make mocs failed"
	kde_src_compile make
}
