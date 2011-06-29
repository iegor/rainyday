#!/bin/bash

# Compiz WM stuff
compiz --replace ccp &
# emerald &
fusion-icon &

# Start wireless connection manager
# wicd-client &

# Start our screen saver
xscreensaver &

# Start some kde-3.5.10 layer apps
# other apps are in the /usr/kde/3.5/bin
#kdeinit_wrapper
#/usr/kde/3.5/bin/kdeinit &
#kicker
#/usr/kde/3.5/bin/dcopserver &
#/usr/kde/3.5/bin/startkde
#konqueror --silent --preload &

# Gnome tools
gnome-do &

# Finally launch app that will be the anchor of our session
#xfce4-panel
docky &

# Run our cf manager script
/usr/bin/cold-fusion
