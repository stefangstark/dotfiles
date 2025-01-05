#!/usr/bin/env bash

case "$1" in
projects)
  aerospace list-windows --all \
    --format '%{window-id}%{right-padding} | %{window-title}%{right-padding}' |
    awk -F '[[:space:]]+\\|[[:space:]]+' '$2 ~ /vim ~\/projects|vim ~\/dotfiles/' |
    sort -n
  ;;

*)
  aerospace list-windows --all |
    awk \
      -F '[[:space:]]+\\|[[:space:]]+' \
      '$2 !~ /Messages|Signal|WhatsApp|Mail|Slack/ && $3 !~ /aerospace-/ {print}' |
    sort -n
  ;;

esac
