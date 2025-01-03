#!/usr/bin/env bash

target=$(aerospace list-windows --all | fzf --header "Select window to grab" --print0 | awk '{ print $1 }')
current_window=$(aerospace list-workspaces --focused)
aerospace move-node-to-workspace --window-id $target --focus-follows-window $current_window
