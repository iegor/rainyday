# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdeutils
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE system monitoring applets."
IUSE="kdehiddenvisibility snmp"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="x11-libs/libXext
	snmp? ( net-analyzer/net-snmp )"

src_unpack() {
	kde-meta_src_unpack
	# Fix the desktop file.
	sed -i -e "s:Hidden=true:Hidden=false:" ksim/ksim.desktop || die "sed failed"
}

src_compile() {
	myconf="$myconf $(use_with snmp)"
	kde-meta_src_compile
}

src_install() {
	kde-meta_src_install
	# see bug 144731
	rm "${D}${KDEDIR}/share/applications/kde/ksim.desktop"
}
