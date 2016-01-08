# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

#
# Original Author: rainman
# Purpose: 
#

ANDROIDDEV_PLATFORM_URI="https://github.com/android/platform_system_core.git"
# ANDROIDDEV_PLATFORM_URI="git://android.git.kernel.org/platform/"
ANDROIDDEV_MAKEFILENAME='Android.mk'

if [ -z ${ANDROIDDEV_TOOLCHAIN} ]; then
	ANDROIDDEV_TOOLCHAIN_GCCPROFILE=$(gcc-config -C -c)
fi

ANDROIDDEV_TOOLCHAIN=${ANDROIDDEV_TOOLCHAIN:="x86"}
