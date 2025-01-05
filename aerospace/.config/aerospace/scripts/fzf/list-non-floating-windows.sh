#!/usr/bin/env bash

aerospace list-windows --all |
  awk \
    -F '[[:space:]]+\\|[[:space:]]+' \
    '$2 !~ /Messages|Signal|WhatsApp|Mail|Slack/ && $3 !~ /aerospace-/ {print}'
