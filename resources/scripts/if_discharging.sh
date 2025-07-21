#!/usr/bin/env bash

# Using upower to check if the system is charging
status=$(upower -i $(upower -e | grep 'BAT') | grep "state" | awk '{print $2}')
if [ "$status" = "discharging" ]; then
    bash -c "$*"
fi
