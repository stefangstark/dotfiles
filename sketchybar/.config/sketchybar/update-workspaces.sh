#!/usr/bin/env bash

source ${CONFIG_DIR}/colors/catppuccin-frappe.sh
# Fix colors of active and previously active window
[ ! -z ${AEROSPACE_PREV_WORKSPACE} ] &&
  sketchybar --set "space.$AEROSPACE_PREV_WORKSPACE" \
    drawing=$([[ $AEROSPACE_PREV_WORKSPACE == [0-9] ]] && echo on || echo off) \
    background.border_color=${DEFAULT_BORDER_COLOR} \
    label.color=${DEFAULT_TEXT_COLOR} \
    icon.color=${DEFAULT_TEXT_COLOR}

[ ! -z ${AEROSPACE_FOCUSED_WORKSPACE} ] &&
  sketchybar --set "space.$AEROSPACE_FOCUSED_WORKSPACE" \
    drawing=on \
    background.border_color=${HIGHLIGHT_BORDER_COLOR} \
    label.color=${HIGHLIGHT_TEXT_COLOR} \
    icon.color=${HIGHLIGHT_TEXT_COLOR}

# Draw icons
# (these query take a lot of time ~100ms)
AEROSPACE_FOCUSED_WORKSPACE=${AEROSPACE_FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}
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

source ${CONFIG_DIR}/icon_map.sh
for workspace in $(echo $workspace_query_json | jq -r ".[] | .workspace" | grep \[0-9\]); do

  workspace_display_id=$(
    echo "$workspace_query_json" |
      jq -r ".[] | select(.workspace == \"$workspace\") | .\"monitor-appkit-nsscreen-screens-id\""
  )

  # INFO: query non-floating windows, if aerospace implements
  windows_in_workspace=$(
    echo "$windows_query_json" |
      jq -r ".[] | select(.workspace == \"$workspace\") | .\"app-name\"" |
      grep -v -e Messages -e Signal -e WhatsApp |
      sort |
      uniq
  )

  # check if any windows in the workspace
  if [ ! $workspace == $AEROSPACE_FOCUSED_WORKSPACE ] && [ -z "$windows_in_workspace" ]; then
    sketchybar --set "space.$workspace" drawing=off
    continue
  fi

  label=""
  # Set IFS to newline to handle multi-word app names correctly
  IFS=$'\n'
  for window in $windows_in_workspace; do
    __icon_map "$window"
    icon_result=$icon_result
    # label="$label$icon_result  "
    [[ -z $label ]] && label="$icon_result" || label="$label  $icon_result"
  done
  # Reset IFS to its default value
  unset IFS
  [[ -z $label ]] && label="—"

  # INFO: add a fullscreen indicator if aerospace implements
  sketchybar --set "space.$workspace" \
    drawing=on \
    label="$label" \
    display="$workspace_display_id"
done
