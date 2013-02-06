# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdebase
KMEXTRA="kdmlib/"
KMEXTRACTONLY="libkonq/konq_defaults.h"
KMCOMPILEONLY="kcontrol/background"
inherit kde-meta eutils
DESCRIPTION="[GIT] KDE login manager, similar to xdm and gdm"
IUSE="elibc_glibc kdehiddenvisibility pam"

DEPEND="pam? ( kde-base/kdebase-pam )
	x11-libs/libXau
	x11-libs/libXtst
	=kde-base/kcontrol-${PV}:${SLOT}"
	# Requires the desktop background settings and kdm kcontrol modules
RDEPEND="${DEPEND}
	=kde-base/kdepasswd-${PV}:${SLOT}
	x11-apps/xinit
    >=x11-misc/imake-1.0.5
	x11-apps/xmessage
	>=x11-misc/xorg-cf-files-1.0.4"
PDEPEND="=kde-base/kdesktop-${PV}:${SLOT}"

src_compile() {
	local myconf="--with-x-binaries-dir=/usr/bin $(use_with pam)"

	if ! use pam && use elibc_glibc; then
		myconf="${myconf} --with-shadow"
	fi

	export USER_LDFLAGS="${LDFLAGS}"

	kde-meta_src_compile myconf configure
	kde_remove_flag kdm/kfrontend -fomit-frame-pointer
	kde-meta_src_compile make
}

src_install() {
	kde-meta_src_install
	cd "${S}/kdm"
	make DESTDIR="${D}" GENKDMCONF_FLAGS="--no-old --no-backup --no-in-notice" install || die "make install failed"

	# Customize the kdmrc configuration
	sed -i -e "s:#SessionsDirs=:SessionsDirs=/usr/share/xsessions\n#SessionsDirs=:" \
		"${D}/${KDEDIR}/share/config/kdm/kdmrc" || die
}

pkg_postinst() {
	kde_pkg_postinst

	# set the default kdm face icon if it's not already set by the system admin
	# because this is user-overrideable in that way, it's not in src_install
	if [ ! -e "${ROOT}${KDEDIR}/share/apps/kdm/faces/.default.face.icon" ];	then
		mkdir -p "${ROOT}${KDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${KDEDIR}/share/apps/kdm/pics/users/default1.png" \
			"${ROOT}${KDEDIR}/share/apps/kdm/faces/.default.face.icon"
	fi
	if [ ! -e "${ROOT}${KDEDIR}/share/apps/kdm/faces/root.face.icon" ]; then
		mkdir -p "${ROOT}${KDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${KDEDIR}/share/apps/kdm/pics/users/root1.png" \
			"${ROOT}${KDEDIR}/share/apps/kdm/faces/root.face.icon"
	fi
}
