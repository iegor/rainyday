# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
GCONF_DEBUG="no"

inherit eutils gnome2 git-2

DESCRIPTION="Collection of GSettings schemas for GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~alpha ~amd64 arm hppa ~ia64 ppc ppc64 ~sh ~sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"

SRC_URI=""

EGIT_REPO_URI="git://git.gnome.org/gsettings-desktop-schemas"
EGIT_COMMIT="925fa376f10054bc7c02fd7e70b6ff3bbac6fc43"
EGIT_SOURCEDIR="${WORKDIR}/${GNOME_ORG_MODULE}-${PV}"

RDEPEND=">=dev-libs/glib-2.21:2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.40"

DOCS="AUTHORS HACKING NEWS README"

# src_unpack() {
#  ebegin "Unpack sources, not needed. This is git :)"
#  eend 0
#}

src_prepare() {
	# Upstream patch to use x-content/unix-software like all of gnome-3.2.1,
	# will be in next release
	epatch "${FILESDIR}/${P}-unix-software.patch"

  gnome2_src_prepare

  # Run autogen.sh
	${S}/autogen.sh
}
