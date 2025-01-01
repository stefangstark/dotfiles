#!/usr/bin/env bash

focused_workspace=$1
last_workspace=$2

sketchybar --set "space.$focused_workspace" \
  background.border_color=${HIGHLIGHT_BORDER_COLOR} \
  label.color=${HIGHLIGHT_TEXT_COLOR} \
  icon.color=${HIGHLIGHT_TEXT_COLOR}

if [ "$2" = "" ]; then
  exit 0

# For quick feedback, always reset the previous workspace
# This heuristic will fail when changing monitor, but it's a good enough approximation
sketchybar --set "space.$last_workspace" \
  background.border_color=${DEFAULT_BORDER_COLOR} \
  label.color=${DEFAULT_TEXT_COLOR} \
  icon.color=${DEFAULT_TEXT_COLOR}
