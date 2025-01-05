#!/usr/bin/env bash
tgt=$1
[[ "$tgt" == "$(aerospace list-workspaces --focused)" ]] &&
  aerospace workspace-back-and-forth ||
  aerospace workspace $tgt
