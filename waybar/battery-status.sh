#!/usr/bin/env bash

# Path to battery capacity file
BATTERY_FILE="/sys/class/power_supply/BAT0/capacity"

# current battery level
BATTERY_LEVEL=$(cat "$BATTERY_FILE")

# Check if the battery level is below the threshold
if [ "$BATTERY_LEVEL" -le "10" ]; then
    notify-send "Low Battery ($BATTERY_LEVEL%)" "fucking charge the laptop"
elif [ "$BATTERY_LEVEL" -le "20" ]; then
    notify-send "Low Battery ($BATTERY_LEVEL%)" "Plug it in dumbass"
fi
