#!/usr/bin/env bash

set -euo pipefail

CURRENT_WORKSPACE=$(aerospace list-workspaces --focused)

launch() {
  kitty --single-instance -d ~ -o remember_window_size=no --title=toggleterm --session <(
    cat <<EOF
os_window_size 120c 15c
launch
EOF
  )
}

get_window_id() {
  aerospace list-windows --all --format "%{window-id}%{right-padding} | %{app-name}-%{window-title}" |
    grep kitty-toggleterm |
    cut -d' ' -f1 |
    head -n1
}

is_app_closed() {
  ! aerospace list-windows --all --format '%{app-name}-%{window-title}' |
    grep -q kitty-toggleterm
}

# main() {
is_app_closed && launch && exit 0

app_window_id=$(get_window_id)
aerospace list-windows --workspace "$CURRENT_WORKSPACE" --format "%{window-id}%{right-padding}" |
  grep -q "$app_window_id" &&
  aerospace move-node-to-workspace NSP --window-id "$app_window_id" &&
  exit 0

aerospace move-node-to-workspace "$CURRENT_WORKSPACE" --window-id "$app_window_id" &&
  aerospace focus --window-id "$app_window_id"
