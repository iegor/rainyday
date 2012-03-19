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
        notify-send "keyboard options xkb are set"
fi

# launch our wm
exec spectrwm
