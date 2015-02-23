#!/bin/bash

# /*********************************************************
# This script will assist in unmounting a flash disk volume
# and cleaning all links and/or media:/ places
# accessible.
#
# 1. umount volume
# 2. clear all links and mount_point
#
# Script will be called from udev rule primarily with
# fs type and some additional options transferred
# *********************************************************/

media_dir=/media

device=$1
mount_point=${media_dir}/$2

if [ ! -d ${mount_point} ]; then
    exit 1;
fi

if ! $(grep ${mount_point} /proc/mounts &> /dev/null); then
    # Unmount volume
    /bin/umount -l ${device}
fi

# Remove mount_point and clean after ourselves (all links, etc.)
/bin/rmdir ${mount_point}

# Erase string from fstab
#/bin/sed -i "\/dev\/${device}.*/d" /etc/fstab
