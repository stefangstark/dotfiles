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
  sketchybar --set $NAME \
    icon= \
    label=VPN \
    icon.drawing=on label.drawing=on \
    label.color="0xff${COLOR_TEAL}" \
    icon.color="0xff${COLOR_TEAL}"

elif [[ $IP_ADDRESS != "" ]]; then
  sketchybar --set $NAME \
    icon= \
    icon.drawing=on label.drawing=off \
    icon.color=${DEFAULT_TEXT_COLOR}

else
  sketchybar --set $NAME \
    icon= \
    icon.drawing=on label.drawing=off \
    icon.color="0xff${COLOR_RED}"

fi
