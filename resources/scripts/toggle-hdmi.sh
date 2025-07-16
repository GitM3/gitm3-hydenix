#!/usr/bin/env bash

position=$(hyprctl monitors | awk '/HDMI-A-1/,/at/ { if ($0 ~ /at /) print $NF }')

if [ "$position" = "-1600x0" ]; then
    hyprctl keyword monitor "HDMI-A-1,1920x1080@60,1600x0,1.2"
else
    hyprctl keyword monitor "HDMI-A-1,1920x1080@60,-1600x0,1.2"
fi
# Why 1600 and not 1920? Because:
# eDP-1 is 1920px wide, but scaled by 1.2 → 1920 / 1.2 = 1600 logical pixels
# To align with Hyprland's logical coordinate system, you must offset by logical width
