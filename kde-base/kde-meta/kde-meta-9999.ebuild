# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit kde-functions
DESCRIPTION="[GIT] kde - merge this to pull in all kde packages"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"
SLOT="3.5"
IUSE="accessibility nls"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

RDEPEND="~kde-base/kdelibs-${PV}
=kde-base/kdeaddons-meta-${PV}:${SLOT}
=kde-base/kdeadmin-meta-${PV}:${SLOT}
=kde-base/kdebase-meta-${PV}:${SLOT}
=kde-base/kdeedu-meta-${PV}:${SLOT}
=kde-base/kdegames-meta-${PV}:${SLOT}
=kde-base/kdegraphics-meta-${PV}:${SLOT}
=kde-base/kdemultimedia-meta-${PV}:${SLOT}
=kde-base/kdenetwork-meta-${PV}:${SLOT}
=kde-base/kdepim-meta-${PV}:${SLOT}
=kde-base/kdetoys-meta-${PV}:${SLOT}
=kde-base/kdesdk-meta-${PV}:${SLOT}
=kde-base/kdeutils-meta-${PV}:${SLOT}
=kde-base/kdeartwork-meta-${PV}:${SLOT}
=kde-base/kdewebdev-meta-${PV}:${SLOT}
accessibility? ( =kde-base/kdeaccessibility-meta-${PV}:${SLOT} )
nls? ( =kde-base/kde-i18n-${PV}:${SLOT} )
!kde-base/kde:3.5"
