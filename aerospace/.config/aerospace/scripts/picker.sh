#!/usr/bin/env bash

mode=$1

case "$mode" in
switch | grab) ;;
*)
  echo $mode unknown && exit 1
  ;;
esac

# TODO: filter floating windows if added to aerospace list-windows
target=$(
  aerospace list-windows --all |
    awk \
      -F '[[:space:]]+\\|[[:space:]]+' \
      '$2 !~ /Messages|Signal|WhatsApp|Mail|Slack/ && $3 !~ /aerospace-/ {print}' |
    fzf \
      --header "Select window to $mode" \
      --print0 |
    awk '{ print $1 }'
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
  ;;

*)
  exit 1 # should not be possible
  ;;

esac
