# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kopete-otr/kopete-otr-0.7.ebuild,v 1.3 2008/09/14 21:57:09 carlo Exp $

EAPI=1

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="This plugin enables Off-The-Record encryption for the KDE instant messenger Kopete."
HOMEPAGE="http://kopete-otr.follefuder.org/"
SRC_URI="http://kopete-otr.follefuder.org/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=net-libs/libotr-3.1.0
	kde-base/kopete:3.5"

need-kde 3.5

src_unpack() {
	kde_src_unpack
	rm -f "${S}/configure"
}
