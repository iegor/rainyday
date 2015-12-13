# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs git-support android-dev

DESCRIPTION="[GIT] android debug bridge"
HOMEPAGE="android.googlesource.com"

EGIT_REPO_URI=${EGIT_REPO_URI:-"https://github.com/android/platform_system_core.git"}
EGIT_BRANCH=${EGIT_BRANCH:-'master'}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
sys-libs/zlib:=
dev-libs/openssl:0=
sys-deve/gcc-config
"
RDEPEND="
${DEPEND}
"

S="${WORKDIR}/platform_system_core"

src_unpack() {
	git-support_src_unpack
}

src_compile() {
	cd adb
	cp ${FILESDIR}/Makefile ./Makefile
	TOOLCHAIN=x86_64-pc-linux-gnu-
	emake
}

src_install(){
	cd adb
	einstall DESTDIR=${D}
}
