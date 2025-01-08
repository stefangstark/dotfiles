#!/usr/bin/env bash

source ${CONFIG_DIR}/colors/catppuccin-frappe.sh

[[ $SENDER == "mouse.entered" ]] &&
  sketchybar \
    --set network.down drawing=on \
    --set network.up drawing=on &&
  exit 0

[[ $SENDER == "mouse.exited" ]] &&
  sketchybar \
    --set network.down drawing=off \
    --set network.up drawing=off &&
  exit 0

IP_ADDRESS=$(scutil --nwi | grep address | sed 's/.*://' | tr -d ' ' | head -1)
IS_VPN=$(scutil --nwi | grep -m1 'utun' | awk '{ print $1 }')

if [[ $IS_VPN != "" ]]; then
  COLOR="0xff${COLOR_TEAL}"
  ICON=
  LABEL="VPN"
elif [[ $IP_ADDRESS != "" ]]; then
  COLOR=${DEFAULT_TEXT_COLOR}
  ICON=
  LABEL=""
else
  COLOR="0xff${COLOR_RED}"
  ICON=
  LABEL="Not Connected"
fi

sketchybar --set $NAME \
  icon=$ICON \
  icon.font="Hack Nerd Font:Bold:16.0" \
  label="$LABEL"
