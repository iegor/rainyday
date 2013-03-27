#!/bin/bash

# Set background
xsetbg -onroot -fullscreen -center -shrink -border black /home/rainman/.scrotwm/desktop.png

sleep .2

# auto launch apps
/usr/bin/xscreensaver -no-splash &

# set xkb options
setxkbmap -option grp:shift_caps_toggle
setxkbmap -model pc104 -layout us,ru -variant .winkeys
if [ "$?" = "0" ]; then
        notify-send "xkb is set"
fi

exec spectrwm
