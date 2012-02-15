#!/bin/bash

#determine who is our current user
current_user=$(whoami)
#zenity --info --text "current user is: ${current_user}"
cf_dir=/home/${current_user}/.coldfusion
cf_cfgd=${cf_dir}/config

# WORKAROUND !!!
# reown config files and some of dirs that was set by installation
#if [ -f ${cf_dir}/status/first_time_run ]; then
#    sudo chown -r ${cf_dir}
#fi

# Copy gtk look settings file from config dir
cp -L ${cf_cfgd}/gtk.conf /home/${current_user}/.gtkrc-2.0
# Copy coldfusion config to compiz config dir
cp -L ${cf_cfgd}/compiz.ini /home/${current_user}/.config/compiz/compizconfig/Default.ini

# Start Compiz WM
compiz --replace --use-root-window ccp &
# emerald &
fusion-icon &

# Start wireless connection manager
# wicd-client &

sleep 5
# Start our screen saver
xscreensaver &

# Start up a clock
xclock -digital &
xcalendar &
pavucontrol &
trayer --widthtype pixel --width 800 --heighttype pixel --height 48 --SetDockType false --align left --edge bottom &

# launch some gkrellm
# gkrellm &

# Finally launch app that will be the anchor of our session
# docky &

# set xkb options
setxkbmap -option grp:shift_caps_toggle
setxkbmap -model pc104 -layout us,ru -variant .winkeys
if [ "$?" = "0" ]; then
	notify-send "keyboard options xkb are set"
fi

sleep 5
# Run our cf manager script
/usr/bin/cold-fusion

#doing exit stuff
cp -L /home/${current_user}/.config/compiz/compizconfig/Default.ini ${cf_cfgd}/compiz.ini
cp -L /home/${current_user}/.gtkrc-2.0 ${cf_cfgd}/gtk.conf
