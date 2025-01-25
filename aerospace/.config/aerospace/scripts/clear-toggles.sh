#!/usr/bin/env bash

WDIR="$(dirname "$(realpath "$0")")/fzf"

$WDIR/list-windows.sh toggles |
  awk '{ print $1 }' |
  xargs -I {} aerospace move-node-to-workspace --window-id {} NSP
