# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdepim
KMCOPYLIB="libkdepim libkdepim/
	libkpimidentities.la libkpimidentities/"
KMEXTRACTONLY="libkdepim/
	libkpimidentities/
	kontact/plugins/"
KMEXTRA="
	kontact/plugins/newsticker/
	kontact/plugins/summary/
	kontact/plugins/weather/"
# We remove some plugins that are related to external kdepim programs,
# because they also need libs from korganizer, kpilot etc... so to emerge
# kontact we'd also need ALL the other programs, thus, it's better to emerge
# kontact's plugins in the ebuild of its program.
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE personal information manager"
IUSE=""

DEPEND="=kde-base/libkdepim-${PV}:${SLOT}
		=kde-base/libkpimidentities-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

pkg_postinst() {
	kde_pkg_postinst

	elog "If you're using kde-misc/basket, please re-emerge it now to avoid crashes with ${PN}."
	elog "cf. https://bugs.gentoo.org/show_bug.cgi?id=174872 for details."
}
