# TODO: filter floating windows if added to aerospace list-windows

# fzf execute runs as an external shell
WDIR="$(dirname "$(realpath "$0")")/fzf"
MODE=$1

read -r mode target <<<$(
  fzf \
    --header "Enter to switch | \ to grab | <ctrl-x> to close" \
    --bind "start:reload(${WDIR}/list-non-floating-windows.sh $MODE)" \
    --bind 'enter:become(echo -n "switch "; echo {} | cut -f 1 -d " ")' \
    --bind '\:become(echo -n "grab "; echo {} | cut -f 1 -d " ")' \
    --bind "ctrl-x:execute-silent(${WDIR}/close-window.sh {})+reload(${WDIR}/list-non-floating-windows.sh $MODE)" \
    --bind "ctrl-p:reload(${WDIR}/list-non-floating-windows.sh projects)" \
    --multi
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
  sketchybar --trigger aerospace_update_unfocused_window
  ;;

*)
  exit 1
  ;;

esac
