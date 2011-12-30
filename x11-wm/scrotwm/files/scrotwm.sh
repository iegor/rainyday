#!/bin/bash

# Set background
xsetbg -onroot -fullscreen -center -shrink -border black /home/rainman/.scrotwm/desktop.png

sleep .2

#xrandr --dpi 96

# auto launch apps
# /usr/libexec/gnome-settings-daemon &
# /usr/bin/gnome-power-manager &
# /usr/bin/nm-applet &
# /usr/bin/gkrellm &
/usr/bin/xscreensaver -no-splash &

# set xkb options
setxkbmap -option grp:shift_caps_toggle
setxkbmap -model pc104 -layout us,ru -variant .winkeys
if [ "$?" = "0" ]; then
        notify-send "keyboard options xkn are set"
fi


# Start kde support
kdehome=$HOME/.kde
test -n "$KDEHOME" && kdehome=`echo "$KDEHOME"|sed "s,^~/,$HOME/,"`

# see kstartupconfig source for usage
mkdir -m 700 -p $kdehome
mkdir -m 700 -p $kdehome/share
mkdir -m 700 -p $kdehome/share/config
cat >$kdehome/share/config/startupconfigkeys <<EOF
kcminputrc Mouse cursorTheme ''
kcminputrc Mouse cursorSize ''
kpersonalizerrc General FirstLogin true
ksplashrc KSplash Theme Default
kcmrandrrc Display ApplyOnStartup false
kcmrandrrc [Screen0]
kcmrandrrc [Screen1]
kcmrandrrc [Screen2]
kcmrandrrc [Screen3]
kcmfonts General forceFontDPI 0
EOF
kstartupconfig
if test $? -ne 0; then
    xmessage -geometry 500x100 "Could not start kstartupconfig. Check your installation."
fi
. $kdehome/share/config/startupconfig

# XCursor mouse theme needs to be applied here to work even for kded or ksmserver
if test -n "$kcminputrc_mouse_cursortheme" -o -n "$kcminputrc_mouse_cursorsize" ; then
    kapplymousetheme "$kcminputrc_mouse_cursortheme" "$kcminputrc_mouse_cursorsize"
    if test $? -eq 10; then
        export XCURSOR_THEME=default
    elif test -n "$kcminputrc_mouse_cursortheme"; then
        export XCURSOR_THEME="$kcminputrc_mouse_cursortheme"
    fi
    if test -n "$kcminputrc_mouse_cursorsize"; then
        export XCURSOR_SIZE="$kcminputrc_mouse_cursorsize"
    fi
fi

dl=$DESKTOP_LOCKED
unset DESKTOP_LOCKED # Don't want it in the environment

if test "$kcmfonts_general_forcefontdpi" -eq 120; then
    xrdb -quiet -merge -nocpp <<EOF
Xft.dpi: 120
EOF
elif test "$kcmfonts_general_forcefontdpi" -eq 96; then
    xrdb -quiet -merge -nocpp <<EOF
Xft.dpi: 96
EOF
fi

exepath=`kde-config --path exe | tr : '\n'`

for prefix in `echo "$exepath" | sed -n -e 's,/bin[^/]*/,/env/,p'`; do
  for file in "$prefix"*.sh; do
    test -r "$file" && . "$file"
  done
done

# Source scripts in /etc/X11/xinit/xinitrc.d/ for system-level defined stuff
if test -d "/etc/X11/xinit/xinitrc.d/"; then
  for file in "/etc/X11/xinit/xinitrc.d/"*; do
    test -x "$file" && . "$file"
  done
fi

usr_odir=$HOME/.fonts/kde-override
usr_fdir=$HOME/.fonts

# Add any user-installed font directories to the X font path
kde_fontpaths=$usr_fdir/fontpaths
do_usr_fdir=1
do_usr_odir=1
if test -r "$kde_fontpaths" ; then
    savifs=$IFS
    IFS="
"
    for fpath in `grep -v '^[ 	]*#' < "$kde_fontpaths"` ; do
        rfpath=`echo $fpath | sed "s:^~:$HOME:g"`
        if test -s "$rfpath"/fonts.dir; then
            xset fp+ "$rfpath"
            if test "$rfpath" = "$usr_fdir"; then
                do_usr_fdir=0
            fi
            if test "$rfpath" = "$usr_odir"; then
                do_usr_odir=0
            fi
        fi
    done
    IFS=$savifs
fi

if test -n "$KDEDIRS"; then
  kdedirs_first=`echo "$KDEDIRS"|sed -e 's/:.*//'`
  sys_odir=$kdedirs_first/share/fonts/override
  sys_fdir=$kdedirs_first/share/fonts
else
  sys_odir=$KDEDIR/share/fonts/override
  sys_fdir=$KDEDIR/share/fonts
fi

# We run mkfontdir on the user's font dirs (if we have permission) to pick
# up any new fonts they may have installed. If mkfontdir fails, we still
# add the user's dirs to the font path, as they might simply have been made
# read-only by the administrator, for whatever reason.

# Only do usr_fdir and usr_odir if they are *not* listed in fontpaths
test -d "$sys_odir" && xset +fp "$sys_odir"
test $do_usr_odir -eq 1 && test -d "$usr_odir" && (mkfontdir "$usr_odir" ; xset +fp "$usr_odir")
test $do_usr_fdir -eq 1 && test -d "$usr_fdir" && (mkfontdir "$usr_fdir" ; xset fp+ "$usr_fdir")
test -d "$sys_fdir" && xset fp+ "$sys_fdir"

# Ask X11 to rebuild its font list.
xset fp rehash

xsetroot -cursor_name left_ptr

# Get Ghostscript to look into user's KDE fonts dir for additional Fontmap
if test -n "$GS_LIB" ; then
    GS_LIB=$usr_fdir:$GS_LIB
    export GS_LIB
else
    GS_LIB=$usr_fdir
    export GS_LIB
fi

# Link "tmp" "socket" and "cache" resources to directory in /tmp
# Creates:
# - a directory /tmp/kde-$USER and links $KDEHOME/tmp-$HOSTNAME to it.
# - a directory /tmp/ksocket-$USER and links $KDEHOME/socket-$HOSTNAME to it.
# - a directory /var/tmp/kdecache-$USER and links $KDEHOME/cache-$HOSTNAME to it.
# Note: temporary locations can be overriden through the KDETMP and KDEVARTMP
# environment variables
for resource in tmp cache socket; do
    if ! lnusertemp $resource >/dev/null; then
        echo 'startkde: Call to lnusertemp failed (temporary directories full?). Check your installation.'  1>&2
        xmessage -geometry 600x100 "Call to lnusertemp failed (temporary directories full?). Check your installation."
        exit 1
    fi
done

# In case of dcop sockets left by a previous session, cleanup
dcopserver_shutdown

KDE_FULL_SESSION=true
export KDE_FULL_SESSION
xprop -root -f KDE_FULL_SESSION 8t -set KDE_FULL_SESSION true
KDE_SESSION_UID=$UID
export KDE_SESSION_UID

# We set LD_BIND_NOW to increase the efficiency of kdeinit.
# kdeinit unsets this variable before loading applications.
LD_BIND_NOW=true start_kdeinit_wrapper --new-startup +kcminit_startup
if test $? -ne 0; then
  # Startup error
  echo 'startkde: Could not start kdeinit. Check your installation.'  1>&2
  xmessage -geometry 500x100 "Could not start kdeinit. Check your installation."
fi

# If the session should be locked from the start (locked autologin),
# lock now and do the rest of the KDE startup underneath the locker.
if test -n "$dl"; then
  kwrapper kdesktop_lock --forcelock &
  # Give it some time for starting up. This is somewhat unclean; some
  # notification would be better.
  sleep 1
fi

kdeinit dcopserver &
#kdeinit klauncher &
konqueror --preload &

notify-send "kde sub-routines are initialised"
# launch our wm
exec scrotwm

# killall gnome-settings-daemon
# killall gnome-keyring-daemon

# Clean up
kdeinit_shutdown
dcopserver_shutdown --wait
if test -e ${_KDEDIR}/bin/artsshell ; then artsshell -q terminate ; fi
# KDE4 support
kde4 kdeinit4_shutdown 2>/dev/null

echo 'startkde: Running shutdown scripts...'  1>&2

# Run scripts found in $KDEDIRS/shutdown
for prefix in `echo "$exepath" | sed -n -e 's,/bin[^/]*/,/shutdown/,p'`; do
  for file in `ls "$prefix" 2> /dev/null | egrep -v '(~|\.bak)$'`; do
    test -x "$prefix$file" && "$prefix$file"
  done
done

unset KDE_FULL_SESSION
xprop -root -remove KDE_FULL_SESSION
unset KDE_SESSION_UID