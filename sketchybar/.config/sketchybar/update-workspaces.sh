#!/usr/bin/env bash

source ${CONFIG_DIR}/colors/catppuccin-frappe.sh

current_workspace=$(aerospace list-workspaces --focused)

# quick update workspace color changes
[ ! -z ${AEROSPACE_CURRENT_SPACE} ] &&
  sketchybar --set "space.$AEROSPACE_CURRENT_SPACE" \
    drawing=on \
    background.border_color=${HIGHLIGHT_BORDER_COLOR} \
    label.color=${HIGHLIGHT_TEXT_COLOR} \
    icon.color=${HIGHLIGHT_TEXT_COLOR}

[ ! -z ${AEROSPACE_PREV_WORKSPACE} ] &&
  sketchybar --set "space.$AEROSPACE_CURRENT_SPACE" \
    drawing=on \
    background.border_color=${DEFAULT_BORDER_COLOR} \
    label.color=${DEFAULT_TEXT_COLOR} \
    icon.color=${DEFAULT_TEXT_COLOR}

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

source ${CONFIG_DIR}/icon_map.sh
# TODO: make current window default
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

  # INFO: add fullscreen color when aerospace implements
  if [[ $workspace == $current_workspace ]]; then
    background_border_color=${HIGHLIGHT_BORDER_COLOR}
    text_color=${HIGHLIGHT_TEXT_COLOR}
  else
    background_border_color=${DEFAULT_BORDER_COLOR}
    text_color=${DEFAULT_TEXT_COLOR}
  fi

  sketchybar --set "space.$workspace" \
    drawing=on \
    label="$label" \
    label.font="$label_font" \
    display="$workspace_display_id" \
    background.border_color=${background_border_color} \
    label.color=${text_color} \
    icon.color=${text_color}
done
