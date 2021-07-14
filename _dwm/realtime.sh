#!/bin/bash

print_date() {
    date "+%Y-%m-%d %A %p%I:%M"
}

print_battery() {
    acpi -b | awk '{print $4}' | tr -d ',' | tr '\n' '|'
}

while true
do
    xsetroot -name "🕗$(print_date)"
    # xsetroot -name "🔋$(print_battery) 🕗$(print_date)"
    sleep 2
done
