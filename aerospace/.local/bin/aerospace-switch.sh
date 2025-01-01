#!/usr/bin/env bash

aerospace focus --window-id $(aerospace list-windows --all | fzf --print0 | awk '{ print $1 }')
