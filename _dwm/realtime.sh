#!/bin/bash

print_date() {
    date "+%Y-%m-%d %p%I:%M %A"
}

print_battery() {
    echo $(cat /sys/class/power_supply/BAT1/capacity) \
         $(cat /sys/class/power_supply/BAT1/status)   \
         $(cat /sys/class/power_supply/BAT2/capacity) \
         $(cat /sys/class/power_supply/BAT2/status) 
}

print_disk() {
    df -h | grep "nvme0n1p5" | awk '{print $4, $5}' | tr ' ' '/'
}

print_temp() {
    echo $(head -c 2 /sys/class/thermal/thermal_zone0/temp)C
}

print_wlan() {
    nmcli | grep "wlp0s20f3" | awk 'NR==1{print $4}'
}

while true
do
    xsetroot -name "[$(print_disk)] [$(print_temp)] [$(print_wlan)] [$(print_battery)] [$(print_date)]"
    sleep 2
done
