#!/usr/bin/env bash

source ${CONFIG_DIR}/colors/catppuccin-frappe.sh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
100)
  ICON="􀛨"
  ICON_COLOR=0xCC${COLOR_GREEN}
  ;;
9[0-9])
  ICON="􀛨"
  ICON_COLOR=${DEFAULT_TEXT_COLOR}
  ;;
[6-8][0-9])
  ICON="􀺸"
  ICON_COLOR=${DEFAULT_TEXT_COLOR}
  ;;
[4-5][0-9])
  ICON="􀺶"
  ICON_COLOR=${DEFAULT_TEXT_COLOR}
  ;;
3[0-9])
  ICON="􀛩"
  ICON_COLOR=0xff${COLOR_YELLOW}
  ;;

[1-2][0-9])
  ICON="􀛩"
  ICON_COLOR=0xff${COLOR_RED}
  ;;
*)
  ICON="􀛪"
  ICON_COLOR=0xff${COLOR_RED}
  ;;

esac

if [[ "$CHARGING" != "" ]]; then
  ICON="􀢋"
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON" icon.color=${ICON_COLOR}
