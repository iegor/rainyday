# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KMNAME=kdepim
inherit kde-meta eutils
DESCRIPTION="[GIT] library enable support for sieve (imap server-side filtering standard) in kde apps, used by kmail"
IUSE=""

# The tests are broken. Fixes bug 188946.
RESTRICT="test"
