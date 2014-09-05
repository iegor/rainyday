# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit git-support eutils cmake-utils

DESCRIPTION="[GIT] CodeLite is an open source, free, cross platform IDE for the C/C++ programming languages"
HOMEPAGE="http://www.codelite.org"

EGIT_REPO_URI="git://github.com/eranif/${PN}"
EGIT_BRANCH="${PV}"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sftp lldb clang pch"

DEPEND="dev-util/cmake
	x11-libs/wxGTK:3.0[X]
	sftp? ( net-libs/libssh )"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		$(cmake-utils_use_enable clang CLANG)
		-DWITH_WXC=0
		-DCOMY_WX_LIBS=1
		$(cmake-utils_use_with pch PCH)
		$(cmake-utils_use_enable sftp SFTP)
		$(cmake-utils_use_enable lldb LLDB)
	)
	ebegin "cmake configure"
	cmake-utils_src_configure
	eend $?
}

src_compile() {
	cmake-utils_src_compile
}
