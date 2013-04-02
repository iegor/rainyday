# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/baghira/baghira-0.8.ebuild,v 1.4 2009/09/04 08:24:10 ssuominen Exp $
EAPI=2
ARTS_REQUIRED=never

inherit kde git-2

DESCRIPTION="Baghira - an OS-X like style for KDE"
#HOMEPAGE="http://baghira.sourceforge.net/"
#SRC_URI="mirror://sourceforge/baghira/${P}.tar.bz2"

EGIT_REPO_URI="git://github.com/iegor/x11-themes-baghira.git"
EGIT_SOURCEDIR="${WORKDIR}/baghira-${PV}"
EGIT_COMMIT="stable_8_0"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="=kde-base/kwin-3.5*
	=kde-base/konqueror-3.5*"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}-glibc-2.10.patch" )

need-kde 3.5
