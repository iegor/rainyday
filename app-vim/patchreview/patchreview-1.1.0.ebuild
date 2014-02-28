# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

DESCRIPTION="vim plugin: allows easy single or multipatch code or diff reviews"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1563"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=21050 -> ${P}.zip"
LICENSE="WTFPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"

VIM_PLUGIN_HELPFILES="patchreview"

DEPEND="app-arch/unzip"
RDEPEND=""
