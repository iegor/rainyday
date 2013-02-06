# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdesdk
KMNOMODULE="true"
KMNODOCS="true"
KMEXTRA="kdepalettes/
	kdeaccounts-plugin/
	scheck/
	poxml/
	kprofilemethod/"
inherit kde-meta eutils
DESCRIPTION="[GIT] kdesdk-misc - Various files and utilities"
IUSE="kdehiddenvisibility"
