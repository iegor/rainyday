# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdebase
inherit kde-meta eutils
DESCRIPTION="[GIT] KSysguard, a network enabled task manager/system monitor, with additional functionality of top."
IUSE="kdehiddenvisibility lm_sensors"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="lm_sensors? ( sys-apps/lm_sensors )"
RDEPEND="${DEPEND}"

src_compile() {
	local myconf="--enable-dnssd $(use_with lm_sensors sensors)"
	kde-meta_src_compile
}
