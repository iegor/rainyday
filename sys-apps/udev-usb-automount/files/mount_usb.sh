#!/bin/bash

# /*********************************************************
# This script will assist in mounting a flash disk volume to
# system and making some links and/or media:/ places
# accessible.
#
# 1. create and write string to fstab
# 2. mount volume according to string from fstab
#
# Script will be called from udev rule primarily with
# fs type and some additional options transferred
# *********************************************************/

media_dir=/media

device=$1
fstype=$2
mount_point=${media_dir}/$3

# Create directory "mount_point"
/bin/mkdir -p ${mount_point}
/bin/chown rainman:disk ${mount_point}

# Write string to fstab
case "${fstype}" in
"vfat")
	/bin/sed -i "\$a\/dev\/${device} ${mount_point} vfat rw,noauto,noatime,dmask=022,user,fmask=133,uid=rainman,gid=rainman 0 0" /etc/fstab
;;
"ntfs")
	/bin/sed -i "\$a\/dev\/${device} ${mount_point} ntfs-3g rw,noauto,uid=rainman,gid=rainman,dmask=000,fmask=111,user,allow_other 0 0" /etc/fstab
;;
*)
	/bin/sed -i "\$a\/dev\/${device} ${mount_point} ${fstype} defaults,user 0 0" /etc/fstab
;;
esac

# mount ${mount_point}
