#!/bin/bash

MODE="$1"
CONFIG="$HOME/.config/waybar/scripts/waybar-light-controls/default_values/default_temperature.conf"

temperature=$(<"$CONFIG")

if [ "$MODE" == "up" ]; then
    temperature=$((temperature + 300))
    [ "$temperature" -gt 6500 ] && temperature=6500
elif [ "$MODE" == "down" ]; then
    temperature=$((temperature - 300))
    [ "$temperature" -lt 2900 ] && temperature=2900
fi

echo "$temperature" > "$CONFIG"
hyprctl hyprsunset temperature "$temperature" > /dev/null 2>&1

# ---------- вывод для Waybar ----------
ICON="☀️"
[ "$temperature" -le 4500 ] && ICON="🌙"

echo "$ICON ${temperature}K"
