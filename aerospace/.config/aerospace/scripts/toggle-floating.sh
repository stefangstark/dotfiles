#!/usr/bin/env bash

set -euo pipefail

APP_NAME="$1"
APP_BUNDLE_ID="$2"

# Requires this to be in aerospace.toml:
#   [[on-window-detected]]
#   if.app-id = APP_BUNDLE_ID (eg 'net.whatsapp.WhatsApp')
#   run = 'layout floating'

target=$(
  aerospace list-windows --all --json \
    --format '%{window-id}%{window-title}%{app-name}%{workspace}%{app-bundle-id}' |
    jq --arg APP_BUNDLE_ID "$APP_BUNDLE_ID" \
      '.[] | select(.["app-bundle-id"] == $APP_BUNDLE_ID)'
)
window_id=$(echo $target | jq '.["window-id"]')

# Open if unopened
[[ -z $window_id ]] && open -a "$APP_NAME" && exit 0

workspace=$(echo $target | jq '.["workspace"]')
workspace_focused=$(aerospace list-workspaces --focused)

# Move app to focus if in NSP
[[ ${workspace} == \"NSP\" ]] && # No idea why quotes are included
  aerospace move-node-to-workspace $workspace_focused --window-id $window_id &&
  aerospace focus --window-id $window_id &&
  exit 0

window_focused=$(aerospace list-windows --focused --format '%{window-id}')

# Focus app if unfocused
[[ ! "$window_id" == "$window_focused" ]] &&
  aerospace move-node-to-workspace $workspace_focused --window-id $window_id &&
  aerospace focus --window-id $window_id &&
  exit 0

# Move app to NSP
aerospace move-node-to-workspace NSP --window-id $window_id
