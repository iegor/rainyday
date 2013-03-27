# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akregator/akregator-3.5.10.ebuild,v 1.8 2009/07/12 13:19:02 armin76 Exp $
EAPI="1"
KMNAME=kdepim
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdepim-3.5-patchset-05.tar.bz2"

DESCRIPTION="KDE news feed aggregator."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="konqueror"

DEPEND=">=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/kontact-${PV}:${SLOT}
	!net-www/akregator"
RDEPEND="${DEPEND}
	konqueror? ( kde-base/konqueror-akregator )"

KMCOPYLIB="libkdepim libkdepim
	libkpinterfaces kontact/interfaces"
KMEXTRACTONLY="libkdepim
	kontact/interfaces"
KMEXTRA="kontact/plugins/akregator"

PATCHES=( "${FILESDIR}/${KMNAME}_${PN}-r893152.patch" )
