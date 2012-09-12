ECLASS_DEBUG_OUTPUT=on

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kde.eclass,v 1.223 2009/05/12 12:55:46 tampakrap Exp $

# @ECLASS: feature.eclass
# @MAINTAINER: iegor
# original iegor <rmtdev@gmail.com>
#
# @BLURB: functions for working with portage features.
# @DESCRIPTION: simple feature class contains functions for working with portage features.
# 

inherit base eutils 

# @FUNCTION: feature
# @USAGE: feature feature_name
# @DESCRIPTION:
# This function returns 1 if requested feature is supported (is in list).
# For now it supports only 1 feature check per call
feature() {
	echo ${FEATURES}|while read -d ' ' line; do
		[ [ "${1}" == "${line}" ] ] && return 1;
	done
	return 0;
}
