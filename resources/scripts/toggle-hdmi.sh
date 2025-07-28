#!/run/current-system/sw/bin/bash
# Swap HDMI A1 between left and right
AWK_CMD=$(command -v awk || echo "/usr/bin/awk")
HYPRCTL_CMD=$(command -v hyprctl || echo "/usr/bin/hyprctl")
notify-send "HDMI Toggle" "HDMI Positions swap L&R"

position=$("$HYPRCTL_CMD" monitors | "$AWK_CMD" '/HDMI-A-1/,/at/ { if ($0 ~ /at /) print $NF }')
if [ "$position" = "-1600x0" ]; then
    "$HYPRCTL_CMD" keyword monitor "HDMI-A-1,1920x1080@60,1600x0,1.2"
else
    "$HYPRCTL_CMD" keyword monitor "HDMI-A-1,1920x1080@60,-1600x0,1.2"
fi
# Why 1600 and not 1920? Because:
# eDP-1 is 1920px wide, but scaled by 1.2 → 1920 / 1.2 = 1600 logical pixels
# To align with Hyprland's logical coordinate system, you must offset by logical width
