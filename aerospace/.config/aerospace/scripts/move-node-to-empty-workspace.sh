#!/usr/bin/env bash
target=$(
  aerospace list-workspaces --empty --monitor focused |
    grep \[0-9\] |
    head -n 1
)

[[ -z $target ]] && target=9

aerospace move-node-to-workspace --focus-follows-window $target
