# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdenetwork
inherit kde-meta eutils flag-o-matic
DESCRIPTION="[GIT] KDE: A dialer and front-end to pppd."
IUSE="kdehiddenvisibility"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

RDEPEND="net-dialup/ppp"

src_compile() {
	kde-meta_src_compile
}
