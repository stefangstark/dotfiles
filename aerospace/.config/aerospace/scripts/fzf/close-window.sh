#!/usr/bin/env bash

start=$(aerospace list-workspaces --focused)
aerospace close --quit-if-last-window --window-id $(echo $1 | awk '{print $1}') &&
  aerospace workspace $start &
sketchybar --trigger aerospace_update_unfocused_window
