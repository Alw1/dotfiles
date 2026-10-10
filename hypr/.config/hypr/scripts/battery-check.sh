#!/usr/bin/env bash

WARN_LEVEL=20
CRIT_LEVEL=10

SOUND_WARN="/run/current-system/sw/share/sounds/freedesktop/stereo/bell.oga"
SOUND_CRIT="/run/current-system/sw/share/sounds/freedesktop/stereo/bell.oga"

STATE_FILE="/tmp/battery-check-state"
DEBUG=false
[ "$1" = "--debug" ] && DEBUG=true

BAT=$(ls /sys/class/power_supply/ | grep -i bat | head -1)
[ -z "$BAT" ] && exit 0

LEVEL=$(cat /sys/class/power_supply/$BAT/capacity)
STATUS=$(cat /sys/class/power_supply/$BAT/status)

if $DEBUG; then
    echo "Battery: $BAT | Level: ${LEVEL}% | Status: $STATUS"
    echo "Simulating critical alert..."
    notify-send -u critical -i battery-caution "Battery Critical" "Battery at ${LEVEL}%! Plug in now."
    pw-play "$SOUND_CRIT"
    echo "Simulating warning alert..."
    notify-send -u normal -i battery-low "Battery Low" "Battery at ${LEVEL}%. Consider plugging in."
    pw-play "$SOUND_WARN"
    exit 0
fi

if [ "$STATUS" = "Charging" ] || [ "$STATUS" = "Full" ]; then
    rm -f "$STATE_FILE"
    exit 0
fi

PREV_STATE=$(cat "$STATE_FILE" 2>/dev/null || echo "ok")

if [ "$LEVEL" -le "$CRIT_LEVEL" ] && [ "$PREV_STATE" != "critical" ]; then
    notify-send -u critical -i battery-caution "Battery Critical" "Battery at ${LEVEL}%! Plug in now."
    pw-play "$SOUND_CRIT" &
    echo "critical" > "$STATE_FILE"
elif [ "$LEVEL" -le "$WARN_LEVEL" ] && [ "$PREV_STATE" != "warning" ] && [ "$PREV_STATE" != "critical" ]; then
    notify-send -u normal -i battery-low "Battery Low" "Battery at ${LEVEL}%. Consider plugging in."
    pw-play "$SOUND_WARN" &
    echo "warning" > "$STATE_FILE"
fi
