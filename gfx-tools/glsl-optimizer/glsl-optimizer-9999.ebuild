# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
EGIT_REPO_URI="git://github.com/aras-p/glsl-optimizer.git"
EGIT_BRANCH=master

inherit git-support cmake-utils

DESCRIPTION="[GIT] A C++ library that takes GLSL shaders, does some GPU-independent optimizations on them and outputs GLSL or Metal source back"
HOMEPAGE="https://github.com/aras-p/glsl-optimizer"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="
>=dev-util/cmake-2.8.12.2"
RDEPEND="${DEPEND}"
