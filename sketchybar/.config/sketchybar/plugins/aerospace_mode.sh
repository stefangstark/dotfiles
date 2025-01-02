#!/usr/bin/env bash

source ${CONFIG_DIR}/colors/catppuccin-frappe.sh

case "$AEROSPACE_MODE" in
main | "")
  sketchybar --set $NAME label.drawing=off background.drawing=off
  ;;

disabled)
  sketchybar --set $NAME \
    label=${AEROSPACE_MODE} \
    label.drawing=on \
    label.color=0xff"${COLOR_SURFACE0}" \
    background.drawing=on \
    background.color=0xff"${COLOR_RED}"
  ;;

launch)
  sketchybar --set $NAME \
    label=${AEROSPACE_MODE} \
    label.drawing=on \
    label.color=0xff"${COLOR_SURFACE0}" \
    background.drawing=on \
    background.color=0xff"${COLOR_SKY}"
  ;;

*)
  sketchybar --set $NAME \
    label=${AEROSPACE_MODE} \
    label.drawing=on \
    label.color=0xff"${COLOR_SURFACE0}" \
    background.drawing=on \
    background.color=0xff"${COLOR_ROSEWATER}"
  ;;

esac
