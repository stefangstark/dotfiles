#!/usr/bin/env bash

set -euo pipefail

APP_NAME="$1"
APP_BUNDLE_ID="$2"

# Requires this to be in aerospace.toml:
#   [[on-window-detected]]
#   if.app-id = APP_BUNDLE_ID (eg 'net.whatsapp.WhatsApp')
#   run = 'move-node-to-workspace APP_NAME'

target=$(
  aerospace list-windows --all --json \
    --format '%{window-id}%{window-title}%{app-name}%{workspace}%{app-bundle-id}' |
    jq --arg APP_BUNDLE_ID "$APP_BUNDLE_ID" \
      '.[] | select(.["app-bundle-id"] == $APP_BUNDLE_ID)'
)
window_id=$(echo $target | jq '.["window-id"]')

# Open if unopened
[[ -z $window_id ]] && open -a "$APP_NAME" && exit 0

window_focused=$(aerospace list-windows --focused --format '%{window-id}')

# focus app if unfocused
[[ ! "$window_id" == "$window_focused" ]] &&
  aerospace focus --window-id $window_id &&
  exit 0

[[ "$APP_NAME" == "$(aerospace list-workspaces --focused)" ]] &&
  aerospace workspace-back-and-forth &&
  exit 0

# Otherwise move back to its workspace
aerospace move-node-to-workspace $APP_NAME --window-id $window_id
