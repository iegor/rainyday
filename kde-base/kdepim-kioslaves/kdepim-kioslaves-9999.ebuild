# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdepim
KMMODULE=kioslaves
KMCOPYLIB="libkmime libkmime/"
KMEXTRACTONLY="libkmime/"
KMCOMPILEONLY="libemailfunctions"
inherit kde-meta eutils
DESCRIPTION="[GIT] kioslaves from kdepim package"
IUSE="sasl"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="sasl? ( >=dev-libs/cyrus-sasl-2 )
	=kde-base/libkmime-${PV}:${SLOT}"

src_compile() {
	myconf="$myconf $(use_with sasl)"
	kde-meta_src_compile
}
