# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdebase
KMEXTRA="doc/faq
	doc/glossary
	doc/quickstart
	doc/userguide
	doc/visualdict"
inherit kde-meta eutils
DESCRIPTION="[GIT] The KDE help center."
IUSE="kdehiddenvisibility"

RDEPEND="=kde-base/kdebase-kioslaves-${PV}:${SLOT}
		>=www-misc/htdig-3.2.0_beta6-r1"
