#!/usr/bin/env bash

case "$1" in
projects)
  aerospace list-windows --all \
    --format '%{window-id}%{right-padding} | %{window-title}%{right-padding}' |
    awk -F '[[:space:]]+\\|[[:space:]]+' '$2 ~ /vim ~\/projects|vim ~\/dotfiles/' |
    sort -n
  ;;

all)
  aerospace list-windows --all | sort -n
  ;;

toggles)
  aerospace list-windows --all |
    awk \
      -F '[[:space:]]+\\|[[:space:]]+' \
      '$2 ~ /Messages|Signal|WhatsApp/ || $3 ~ /aerospace-/ {print}' |
    sort -n
  ;;

*)
  aerospace list-windows --all |
    awk \
      -F '[[:space:]]+\\|[[:space:]]+' \
      '$2 !~ /Messages|Signal|WhatsApp|Mail|Slack|Calendar/ && $3 !~ /aerospace-/ {print}' |
    sort -n
  ;;

esac
