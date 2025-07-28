#!/usr/bin/env bash

# Simple Script Selector for Rofi
pkill -x rofi && exit

SCRIPT_DIR="$HOME/hydix/resources/scripts"

# Check if directory exists
if [[ ! -d "$SCRIPT_DIR" ]]; then
  notify-send "Script Selector" "Directory not found: $SCRIPT_DIR"
  exit 1
fi

# Generate list of .sh scripts with descriptions
cd "$SCRIPT_DIR" || exit 1

script_list=""
for script in *.sh; do
  [[ ! -f "$script" ]] && continue
  [[ ! -x "$script" ]] && continue
  [[ "$script" =~ script.?launcher ]] && continue
  [[ "$script" =~ if.?discharging ]] && continue

  # Get description from first comment line
  description=$(head -5 "$script" | grep '^#' | grep -v '^#!/' | head -1 | sed 's/^#[[:space:]]*//')
  [[ -z "$description" ]] && description="No description"

  script_list+="$script\t$description\n"
done

# Nord color scheme
nord_theme='
* {
    background-color: #2e3440;
    text-color: #d8dee9;
    border-color: #4c566a;
    selected-normal-background: #5e81ac;
    selected-normal-foreground: #eceff4;
    alternate-normal-background: #3b4252;
    alternate-normal-foreground: #d8dee9;
    font: "JetBrainsMono Nerd Font 12";
}

window {
    background-color: #2e3440;
    border: 2px;
    border-color: #4c566a;
    border-radius: 8px;
    padding: 10px;
}

inputbar {
    background-color: #3b4252;
    text-color: #d8dee9;
    border-radius: 4px;
    padding: 8px;
    margin: 0px 0px 10px 0px;
}

prompt {
    background-color: transparent;
    text-color: #88c0d0;
}

entry {
    background-color: transparent;
    text-color: #d8dee9;
    placeholder-color: #616e88;
}

listview {
    background-color: transparent;
    columns: 1;
    lines: 10;
    spacing: 2px;
    scrollbar: true;
}

element {
    background-color: transparent;
    text-color: #d8dee9;
    padding: 8px;
    border-radius: 4px;
}

element selected {
    background-color: #5e81ac;
    text-color: #eceff4;
}

element alternate {
    background-color: #3b4252;
}

scrollbar {
    width: 4px;
    border: 0;
    handle-color: #4c566a;
    handle-width: 4px;
    padding: 0;
}
'

# Show in rofi with Nord theme
selected=$(echo -e "$script_list" | rofi -dmenu -p "Scripts" -i -theme-str "$nord_theme")

# Exit if nothing selected
[[ -z "$selected" ]] && exit 0

# Get script name (first column)
script_name=$(echo "$selected" | cut -f1)

# Run the script
cd "$SCRIPT_DIR" || exit
bash "$script_name"
