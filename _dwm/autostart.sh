#!/bin/bash

xinput set-prop 11 'libinput Natural Scrolling Enabled' 1
xinput set-prop 11 'libinput Tapping Enabled' 1
xinput set-prop 11 'libinput Accel Speed' +0.5

fcitx5 &

picom &

bash ~/.dwm/random_background.sh &

bash ~/.dwm/realtime.sh &
