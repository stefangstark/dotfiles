#!/usr/bin/env bash

# TODO: filter floating windows if added to aerospace list-windows

# fzf execute runs as an external shell
# all "bind" targets need to be externally accessible
WDIR="$(dirname "$(realpath "$0")")/fzf"
MODE=$1

read -r action target <<<$(
  fzf \
    --header $'Actions: <enter> to switch | <tab> to grab | <ctrl-x> to close\nModes: <ctrl-r> normal | <ctrl-p> projects | <ctrl-a> all' \
    --bind "start:reload(${WDIR}/list-windows.sh $MODE)" \
    --bind 'enter:become(echo -n "switch "; echo {} | cut -f 1 -d " ")' \
    --bind 'tab:become(echo -n "grab "; echo {} | cut -f 1 -d " ")' \
    --bind "ctrl-x:execute-silent(${WDIR}/close-window.sh {})+reload(${WDIR}/list-windows.sh $MODE)" \
    --bind "ctrl-p:reload(${WDIR}/list-windows.sh projects)" \
    --bind "ctrl-a:reload(${WDIR}/list-windows.sh all)" \
    --bind "ctrl-r:reload(${WDIR}/list-windows.sh)"

)

[[ -z $target ]] && exit 1

case "$action" in
switch)
  aerospace move-node-to-workspace $target
  aerospace focus --window-id $target
  ;;

grab)
  current_window=$(aerospace list-workspaces --focused)
  aerospace move-node-to-workspace \
    --window-id $target \
    --focus-follows-window $current_window
  sketchybar --trigger aerospace_update_unfocused_window
  ;;

*)
  exit 1
  ;;

esac
