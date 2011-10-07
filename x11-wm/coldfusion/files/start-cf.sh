#!/bin/bash

# Copy gtk look settings file from config dir
cp -L ~/.coldfusion/config/gtk.conf ~/.gtkrc-2.0
# Copy coldfusion config to compiz config dir
cp -L ~/.coldfusion/config/compiz.ini ~/.config/compiz/compizconfig/Default.ini

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
trayer --widthtype pixel --width 800 --heighttype pixel --height 48 --SetDockType false --align left --edge bottom &

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

#doing exit stuff
cp -L ~/.config/compiz/compizconfig/Default.ini ~/.coldfusion/config/compiz.ini
cp -L ~/.gtkrc-2.0 ~/.coldfusion/config/gtk.conf
