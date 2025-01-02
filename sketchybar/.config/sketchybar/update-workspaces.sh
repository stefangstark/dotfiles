#!/usr/bin/env bash

focused_workspace=$1
last_workspace=$2
CONFIG_DIR=$(dirname $0)

# HACK: should be done with subscription events ...
source ${CONFIG_DIR}/colors/catppuccin-frappe.sh

DEFAULT_BACKGROUND_COLOR=0xff"${COLOR_SURFACE2}"
DEFAULT_TEXT_COLOR=0xff"${COLOR_TEXT}"
DEFAULT_BORDER_COLOR=0xff"${COLOR_SURFACE0}"

HIGHLIGHT_BACKGROUND_COLOR=0xff"${COLOR_SURFACE2}"
HIGHLIGHT_TEXT_COLOR=0xCC"${COLOR_MAROON}"
HIGHLIGHT_BORDER_COLOR=0xCC"${COLOR_MAROON}"

sketchybar --set "space.$focused_workspace" \
  background.border_color=${HIGHLIGHT_BORDER_COLOR} \
  label.color=${HIGHLIGHT_TEXT_COLOR} \
  icon.color=${HIGHLIGHT_TEXT_COLOR}

if [ ! "$2" = "" ]; then
  sketchybar --set "space.$last_workspace" \
    background.border_color=${DEFAULT_BORDER_COLOR} \
    label.color=${DEFAULT_TEXT_COLOR} \
    icon.color=${DEFAULT_TEXT_COLOR}
fi

# Those query take a lot of time (100ms)
workspace_query_json=$(
  aerospace list-workspaces --all \
    --format '%{workspace}%{monitor-appkit-nsscreen-screens-id}' \
    --json
)
windows_query_json=$(
  aerospace list-windows --all \
    --format '%{workspace} %{app-name}' \
    --json
)

# Update per workspace
for workspace in $(echo $workspace_query_json | jq -r ".[] | .workspace" | grep -v NSP); do

  workspace_display_id=$(
    echo "$workspace_query_json" |
      jq -r ".[] | select(.workspace == \"$workspace\") | .\"monitor-appkit-nsscreen-screens-id\""
  )

  # Get all the windows in the workspace
  windows_in_workspace=$(
    echo "$windows_query_json" |
      jq -r ".[] | select(.workspace == \"$workspace\") | .\"app-name\"" |
      grep -v -e Messages -e Mail -e Signal -e Slack -e WhatsApp |
      sort |
      uniq
  )

  # check if any windows in the workspace
  if [ "$windows_in_workspace" = "" ]; then
    sketchybar --set "space.$workspace" drawing=off
    continue
  fi

  source ${CONFIG_DIR}/icon_map.sh
  label=""
  label_font="sketchybar-app-font:Normal:12.0"
  # Set IFS to newline to handle multi-word app names correctly
  IFS=$'\n'
  for window in $windows_in_workspace; do
    __icon_map "$window"
    icon_result=$icon_result
    label="$label$icon_result  "
  done
  # Reset IFS to its default value
  unset IFS
  # echo $workspace $label

  sketchybar --set "space.$workspace" \
    drawing=on \
    label="$label" \
    label.font="$label_font" \
    display="$workspace_display_id"

done
