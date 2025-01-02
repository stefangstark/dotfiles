#!/usr/bin/env bash

# Requires this to be in aerospace.toml:
#   [[on-window-detected]]
#   if.app-id = "net.kovidgoyal.kitty"
#   if.window-title-regex-substring = "toggleterm"
#   run = 'layout floating'
#

set -euo pipefail

windows=$(
  aerospace list-windows --all --json \
    --format '%{window-id}%{window-title}%{app-name}%{workspace}'
)

target=$(
  echo $windows |
    jq '.[] | select(
        (.["app-name"] == "kitty") and
        (.["window-title"] == "toggleterm")
      )'
)

window_id=$(echo $target | jq '.["window-id"]')

[[ -z $window_id ]] &&
  kitty \
    -d ~ \
    --single-instance \
    --title=toggleterm \
    -o remember_window_size=no \
    -o initial_window_width=120c \
    -o initial_window_height=15c &&
  exit 0

workspace=$(echo $target | jq '.["workspace"]')
workspace_focused=$(aerospace list-workspaces --focused)

[[ ${workspace} == \"NSP\" ]] && # No idea why quotes are included
  aerospace move-node-to-workspace $workspace_focused --window-id $window_id &&
  aerospace focus --window-id $window_id &&
  exit 0

focused=$(aerospace list-windows --focused --format '%{window-id}')

[[ ! "$window_id" == "$focused" ]] &&
  aerospace focus --window-id $window_id &&
  exit 0

aerospace move-node-to-workspace NSP --window-id $window_id
