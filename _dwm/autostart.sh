#!/bin/sh

xinput set-prop 11 'libinput Natural Scrolling Enabled' 1
xinput set-prop 11 'libinput Tapping Enabled' 1
xinput set-prop 11 'libinput Accel Speed' +0.5

fcitx5 -d

picom --no-vsync &

sh ~/.dwm/random_background.sh &

sh ~/.dwm/status_bar.sh &
