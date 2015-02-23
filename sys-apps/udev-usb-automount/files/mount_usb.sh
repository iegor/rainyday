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

if [ ! -d ${mount_point} ]; then
    # Create directory "mount_point"
    /bin/mkdir -p ${mount_point}
fi

/bin/chgrp disk ${mount_point}
/bin/chmod 770 ${mount_point}
/bin/chmod g+s ${mount_point}

if ! $(grep ${mount_point} /proc/mounts &> /dev/null); then
    # Write string to fstab
    case "${fstype}" in
    "vfat")
        #/bin/sed -i "\$a\/dev\/${device} ${mount_point} vfat rw,noauto,relatime,dmask=002,user,fmask=113,gid=disk 0 0" /etc/fstab
        /bin/mount -t vfat -o "rw,noauto,relatime,dmask=002,user,fmask=113,gid=disk" /dev/${device} ${mount_point}
    ;;
    "ntfs")
        #/bin/sed -i "\$a\/dev\/${device} ${mount_point} ntfs-3g rw,noauto,uid=rainman,gid=rainman,dmask=002,fmask=113,user,allow_other 0 0" /etc/fstab
        /bin/mount -t ntfs-3g -o "rw,noauto,relatime,gid=disk,dmask=002,fmask=113,user,allow_other" /dev/${device} {$mount_point}
    ;;
    *)
        #/bin/sed -i "\$a\/dev\/${device} ${mount_point} ${fstype} defaults,user 0 0" /etc/fstab
        mount -t auto -o "rw,noauto,relatime,dmask=002,fmask=113,user" /dev/${device} ${mount_point}
    ;;
    esac
fi
