# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=2
KMNAME=kdelibs

inherit kde-meta flag-o-matic eutils multilib
# Calling this here to ensure we install into git prefix directory
set-kdedir 9999
DESCRIPTION="[GIT] KDE libraries needed by all KDE programs."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"
SLOT="3.5"
IUSE="acl alsa arts branding cups doc jpeg2k kerberos legacyssl utempter openexr spell tiff kernel_linux fam lua kdehiddenvisibility"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

# Added aspell-en as dependency to work around bug 131512.
# Made openssl and zeroconf mandatory dependencies, see bug #172972 and #175984
RDEPEND="
	!=kde-base/artsplugin-mpeglib-${PV}:${SLOT}
	!=kde-base/artsplugin-mpg123-${PV}:${SLOT}
	!=kde-base/kdeaccessibility-${PV}:${SLOT}
	!=kde-base/kdeaddons-${PV}:${SLOT}
	!=kde-base/kdeadmin-${PV}:${SLOT}
	!=kde-base/kdeartwork-${PV}:${SLOT}
	!=kde-base/kdebase-${PV}:${SLOT}
	!=kde-base/kdeedu-${PV}:${SLOT}
	!=kde-base/kdegames-${PV}:${SLOT}
	!=kde-base/kdegraphics-${PV}:${SLOT}
	!=kde-base/kde-${PV}:${SLOT}
	!=kde-base/kdemultimedia-${PV}:${SLOT}
	!=kde-base/kdenetwork-${PV}:${SLOT}
	!=kde-base/kdepim-${PV}:${SLOT}
	!=kde-base/kdesdk-${PV}:${SLOT}
	!=kde-base/kdetoys-${PV}:${SLOT}
	!=kde-base/kdeutils-${PV}:${SLOT}
	!=kde-base/kdewebdev-${PV}:${SLOT}
	!=kde-base/ksync-${PV}:${SLOT}
	!=kde-base/mpeglib-${PV}:${SLOT}
	app-arch/bzip2
	>=dev-libs/libxslt-1.1.16
	>=dev-libs/libxml2-2.6.6
	>=dev-libs/libpcre-6.6
	>=dev-libs/openssl-0.9.7d
	media-libs/fontconfig
	>=media-libs/freetype-2
	media-libs/libart_lgpl
	net-dns/avahi[qt3]
	net-dns/libidn
	app-text/ghostscript-gpl
	x11-libs/libXext
	>=dev-qt/qt-meta-3.3.3:3
	acl? (
		virtual/acl
	)
	alsa? ( media-libs/alsa-lib )
	arts? ( ~kde-base/arts-9999 )
	cups? ( >=net-print/cups-1.1.19 )
	fam? ( virtual/fam )
	jpeg2k? ( media-libs/jasper )
	kerberos? ( virtual/krb5 )
	lua? ( dev-lang/lua )
	openexr? ( >=media-libs/openexr-1.2.2-r2 )
	spell? (
		>=app-dicts/aspell-en-6.0.0
		>=app-text/aspell-0.60.5
	)
	tiff? ( media-libs/tiff )
	utempter? ( sys-libs/libutempter )
	>=x11-themes/hicolor-icon-theme-0.12
"
DEPEND="${RDEPEND}
	sys-devel/gettext
	doc? ( <app-doc/doxygen-1.8.0 )
"
RDEPEND="${RDEPEND}
	!<kde-base/kdebase-startkde-${PV}:${SLOT}
	x11-apps/rgb
	x11-apps/iceauth
	>=x11-misc/xdg-utils-1.0.2-r3
"
PDEPEND=""

# Testing code is rather broken and merely for developer purposes, so disable it.
RESTRICT="test"

#EGIT_REPO_URI="git://github.com/iegor/kdelibs.git"
#EGIT_BRANCH="develop"
#EGIT_SOURCEDIR="${S}"

pkg_setup() {
	if use legacyssl ; then
		echo ""
		elog "You have the legacyssl use flag enabled, which fixes issues with some broken"
		elog "sites, but breaks others instead. It is strongly discouraged to use it."
		elog "For more information, see bug #128922."
		echo ""
	fi

	if ! use utempter ; then
		echo ""
		elog "On some setups, which rely on the correct update of utmp records, not using"
		elog "utempter might not update them correctly. If you experience unexpected"
		elog "behaviour, try to rebuild kde-base/kdelibs with utempter use-flag enabled."
		echo ""
	fi

	# einfo "moving kde file from ${FILESDIR} to ${WORKDIR}"
	# dodir "${WORKDIR}" || eerror "dodir ${WORKDIR}"
	# [[ -x "${WORKDIR}" ]] && einfo "workdir exists"
	# dodir "${WORKDIR}/patches" || eerror "dodir patches"
	# cp -L "${FILESDIR}/kde3" "${WORKDIR}/patches" || eerror "moving files"
}

src_unpack() {
	kde-meta_src_unpack

	# remove this symlink, bug 264767
	rm -f "${WORKDIR}/${P}"/kdeprint/kdeprint

	if use legacyssl ; then
		# This patch won't be included upstream, see bug #128922.
		epatch "${FILESDIR}/kdelibs_3.5.4-kssl-3des.patch"
	fi

	if use utempter ; then
		# Bug #135818 is the eternal reference.
		epatch "${FILESDIR}/kdelibs-3.5_libutempter.patch"
	fi

	# bug 267018
	sed -i '/^SUBDIRS/s/ hicolor / /' pics/Makefile.am
}

src_configure() {
	rm -f "${S}/configure"

	myconf="--with-distribution=Gentoo --disable-fast-malloc
			--with-libart --with-libidn --with-ssl
			--without-hspell
			$(use_enable fam libfam) $(use_enable kernel_linux dnotify)
			$(use_with acl) $(use_with alsa)
			$(use_with arts) $(use_enable cups)
			$(use_with kerberos gssapi) $(use_with tiff)
			$(use_with jpeg2k jasper) $(use_with openexr)
			$(use_with utempter) $(use_with lua)
			$(use_enable kernel_linux sendfile) --enable-mitshm
			$(use_with spell aspell)"

	if has_version x11-apps/rgb; then
		myconf="${myconf} --with-rgbfile=/usr/share/X11/rgb.txt"
	fi

	# fix bug 58179, bug 85593
	# kdelibs-3.4.0 needed -fno-gcse; 3.4.1 needs -mminimal-toc; this needs a
	# closer look... - corsair
	use ppc64 && append-flags "-mminimal-toc"

	# work around bug #120858, gcc 3.4.x -Os miscompilation
	# use x86 && replace-flags "-Os" "-O2" # see bug #120858

	replace-flags "-O3" "-O2" # see bug #148180

	kde_src_configure myconf configure
}

src_compile() {
	kde_src_compile make

	if use doc; then
		emake apidox || die
	fi
}

src_install() {
	kde_src_install

	if use doc; then
		emake DESTDIR="${D}" install-apidox || die
	fi

	# Needed to create lib -> lib64 symlink for amd64 2005.0 profile
	if [ "${SYMLINK_LIB}" = "yes" ]; then
		dosym $(get_abi_LIBDIR ${DEFAULT_ABI}) ${KDEDIR}/lib
	fi

	dodir /etc/env.d

	# List all the multilib libdirs
	local libdirs
	for libdir in $(get_all_libdirs); do
		libdirs="${PREFIX}/${libdir}:${libdirs}"
	done

	# KDE implies that the install path is listed first in KDEDIRS and the user
	# directory (implicitly added) to be the last entry. Doing otherwise breaks
	# certain functionality. Do not break this (once again *sigh*), but read the code.
	# KDE saves the installed path implicitly and so this is not needed, /usr
	# is set in ${PREFIX}/share/config/kdeglobals and so KDEDIRS is not needed.
	cat <<EOF > "${D}"/etc/env.d/45kdepaths-${SLOT} # number goes down with version upgrade
PATH=${PREFIX}/bin
ROOTPATH=${PREFIX}/sbin:${PREFIX}/bin
LDPATH=${libdirs}
MANPATH=${PREFIX}/share/man
CONFIG_PROTECT="${PREFIX}/share/config ${PREFIX}/env ${PREFIX}/shutdown /usr/share/config"
#KDE_IS_PRELINKED=1
# Excessive flushing to disk as in releases before KDE 3.5.10. Usually you don't want that.
#KDE_EXTRA_FSYNC=1
XDG_DATA_DIRS="${PREFIX}/share"
EOF

	# Install shell script to run KDE 3 applications from outside of the KDE 3 desktop
	# See http://lists.kde.org/?t=120569055200005&r=1&w=2 for reference

	# List all the multilib libdirs
	local _libdir _libdirs
	for _libdir in $(get_all_libdirs); do
		_libdirs="${_libdirs}:${PREFIX}/${_libdir}"
	done
	_libdirs=${_libdirs#:}

	# Merge KDE prefix and LDPATH
	# sed -e "s#@REPLACE_PREFIX@#${PREFIX}#" \
	# 	-e  "s#@REPLACE_LIBS@#${_libdirs}#" \
	# 	-i "${WORKDIR}/patches/kde3" || die "sed failed"
	cat <<EOF > "${S}/kde3"
#!/bin/sh
#  Script for launching KDE3 applications from outside of the KDE3 desktop
#  Modify this to match your specific needs, such as setting up needed env. variables,
#  and make sure this script is in $PATH (e.g. make a symlink if necessary).
_KDEDIR=${PREFIX}
export KDEDIRS=${_KDEDIR}:/usr:/usr/local
export PATH=${_KDEDIR}/bin:$(echo ${PATH} | sed 's#/usr/kde/[^/]*/s\?bin:##g')
export ROOTPATH=${_KDEDIR}/sbin:${_KDEDIR}/bin:$(echo ${PATH} | sed 's#/usr/kde/[^/]*/s\?bin:##g')
export LDPATH=${_libdirs}:${LDPATH}
exec "$@"
EOF
	dobin "${S}/kde3"

	# Make sure the target for the revdep-rebuild stuff exists. Fixes bug 184441.
	dodir /etc/revdep-rebuild

cat <<EOF > "${D}"/etc/revdep-rebuild/50-kde3
SEARCH_DIRS="${PREFIX}/bin ${PREFIX}/lib*"
EOF
}
