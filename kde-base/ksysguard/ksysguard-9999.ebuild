# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksysguard/ksysguard-3.5.10.ebuild,v 1.7 2009/07/12 11:00:43 armin76 Exp $
EAPI="1"
KMNAME=kdebase
inherit kde-meta eutils

DESCRIPTION="[GIT] KSysguard, a network enabled task manager/system monitor, with additional functionality of top."
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility lm_sensors"
KDE_DOWNLOAD_SOURCE="git"

DEPEND="lm_sensors? ( sys-apps/lm_sensors )"
RDEPEND="${DEPEND}"

src_compile() {
	local myconf="--enable-dnssd $(use_with lm_sensors sensors)"

	kde-meta_src_compile
}
