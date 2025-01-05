#!/usr/bin/env bash

# TODO: filter floating windows if added to aerospace list-windows
read -r mode target <<<$(
  aerospace list-windows --all |
    awk \
      -F '[[:space:]]+\\|[[:space:]]+' \
      '$2 !~ /Messages|Signal|WhatsApp|Mail|Slack/ && $3 !~ /aerospace-/ {print}' |
    fzf \
      --header "Enter to switch | Tab to grab" \
      --bind 'enter:become(echo -n "switch "; echo {} | cut -f 1 -d " ")' \
      --bind 'tab:become(echo -n "grab "; echo {} | cut -f 1 -d " ")'
)

[[ -z $target ]] && exit 1

case "$mode" in
switch)
  aerospace move-node-to-workspace $target
  aerospace focus --window-id $target
  ;;

grab)
  current_window=$(aerospace list-workspaces --focused)
  aerospace move-node-to-workspace \
    --window-id $target \
    --focus-follows-window $current_window
  sketchybar --trigger aerospace_workspace_change
  ;;

*)
  exit 1 # should not be possible
  ;;

esac
