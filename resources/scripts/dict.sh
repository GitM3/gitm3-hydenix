#!/run/current-system/sw/bin/bash
# Focus or open dictionary application
# Set a comprehensive PATH to ensure we find all commands
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH"

# Find command paths dynamically
PGREP_CMD=$(command -v pgrep || echo "/usr/bin/pgrep")
JQ_CMD=$(command -v jq || echo "/usr/bin/jq")
HYPRCTL_CMD=$(command -v hyprctl || echo "/usr/bin/hyprctl")
HEAD_CMD=$(command -v head || echo "/usr/bin/head")

# Try to find goldendict executable
GOLDENDICT_CMD=""
for cmd in "goldendict" "goldendict-ng" "GoldenDict"; do
    if command -v "$cmd" >/dev/null 2>&1; then
        GOLDENDICT_CMD=$(command -v "$cmd")
        break
    fi
done

echo "found $GOLDENDICT_CMD"

# Fallback if not found in PATH
if [ "$GOLDENDICT_CMD" = "" ]; then
    GOLDENDICT_CMD="/usr/bin/goldendict"
fi

# Main logic
GOLDEN_PID=$("$PGREP_CMD" -i "golden")
if [ "$GOLDEN_PID" != "" ]; then
    GOLDEN_WINDOW=$("$HYPRCTL_CMD" clients -j | "$JQ_CMD" -r '.[] | select(.class | test("(?i)golden")) | .address' | "$HEAD_CMD" -n1)
    if [ "$GOLDEN_WINDOW" != "" ]; then
        echo "FOUND window, focusing"
        "$HYPRCTL_CMD" dispatch focuswindow "address:$GOLDEN_WINDOW"
    else
        GOLDEN_CLASS=$("$HYPRCTL_CMD" clients -j | "$JQ_CMD" -r '.[] | select(.class | test("(?i)golden")) | .class' | "$HEAD_CMD" -n1)
        if [ "$GOLDEN_CLASS" != "" ]; then
            echo "FOUND class, focusing"
            "$HYPRCTL_CMD" dispatch focuswindow "$GOLDEN_CLASS"
        else
            echo "opening"
            "$GOLDENDICT_CMD" &
        fi
    fi
else
    echo "opening from zero"
    "$GOLDENDICT_CMD" &
fi
