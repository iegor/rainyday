# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit git-support

DESCRIPTION="Linux Virtual Terminal setcolors utility"
HOMEPAGE="https://github.com/EvanPurkhiser/linux-vt-setcolors"
SRC_URI=""
EGIT_REPO_URI=${EGIT_REPO_URI:="git://github.com/EvanPurkhiser/linux-vt-setcolors.git"}
EGIT_BRANCH=master

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	git-support_src_unpack
}

src_compile() {
	emake setcolors
}

# src_install() {
# 	emake install

	# dodir ${D}/usr/share/${PN}
	# insinto ${D}/usr/share/${PN}
	# doins example-colors/*
# }
