# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdeutils
inherit kde-meta eutils
DESCRIPTION="[GIT] kded module that can support various types of hardware input devices, such as those on keyboards."
IUSE="kdehiddenvisibility pbbuttonsd"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="x11-libs/libXtst
	pbbuttonsd? ( app-laptop/pbbuttonsd )"

src_compile() {
	local myconf="$(use_with pbbuttonsd powerbook)"
	kde-meta_src_compile
}
