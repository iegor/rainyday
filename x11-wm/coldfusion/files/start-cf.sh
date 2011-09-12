#!/bin/bash

# Compiz WM stuff
compiz --replace --use-root-window ccp &
# emerald &
fusion-icon &

# Start wireless connection manager
# wicd-client &

# Start our screen saver
xscreensaver &

# Start up a clock
xclock -digital &
xcalendar &
pavucontrol &

# Start some kde-3.5.10 layer apps
# other apps are in the /usr/kde/3.5/bin
#kdeinit_wrapper
#/usr/kde/3.5/bin/kdeinit &
#kicker
#/usr/kde/3.5/bin/dcopserver &
#/usr/kde/3.5/bin/startkde
#konqueror --silent --preload &

# Gnome tools
# gnome-do &

# Finally launch app that will be the anchor of our session
# docky &
# avant-window-navigator &


# set xkb options
setxkbmap -option grp:shift_caps_toggle
# setxkbmap -option grp_led:scroll
setxkbmap -model pc104 -layout us,ru -variant .winkeys
if [ "$?" = "0" ]; then
	notify-send "keyboard options xkn are set"
fi

# Run our cf manager script
/usr/bin/cold-fusion
