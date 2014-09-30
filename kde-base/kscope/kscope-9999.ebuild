# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kscope/kscope-1.6.2.ebuild,v 1.7 2009/10/12 11:09:13 ssuominen Exp $

EAPI=2
KMNAME=kdesdk
inherit kde-meta
DESCRIPTION="[LIVE] KScope is a KDE front-end to Cscope."
HOMEPAGE="http://kscope.sourceforge.net/"
LICENSE="BSD"
IUSE=""
KEYWORDS="amd64 ppc sparc x86"

RDEPEND="kde-base/kate:3.5
	media-gfx/graphviz
	dev-util/ctags
	>=dev-util/cscope-15.5-r4"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"
