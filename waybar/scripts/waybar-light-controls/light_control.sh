#!/bin/bash

MODE="$1"
CONFIG="$HOME/.config/waybar/scripts/waybar-light-controls/default_values/default_light.conf"

light=$(<"$CONFIG")

if [ "$MODE" == "up" ]; then
    light=$((light + 10))
    [ "$light" -gt 100 ] && light=100
elif [ "$MODE" == "down" ]; then
    light=$((light - 10))
    [ "$light" -lt 20 ] && light=20
fi

echo "$light" > "$CONFIG"
hyprctl hyprsunset gamma "$light" > /dev/null 2>&1

# ---------- вывод для Waybar ----------
ICON="☀️"
[ "$light" -le 40 ] && ICON="🌙"

echo "$ICON $light%"
