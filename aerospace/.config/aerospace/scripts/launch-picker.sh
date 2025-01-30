#!/usr/bin/env bash

MODE=$1

# TODO: close window if focused
[[ $(aerospace list-windows --focused --format '%{window-title}') == 'aerospace-switch' ]] &&
  aerospace close &&
  exit 0

kitty \
  --config $HOME/.config/kitty/program.conf \
  --title=aerospace-switch \
  picker.sh $MODE
