#! /bin/bash

alias ls='ls -G --color=auto'
alias ll='ls -lhGA --color=auto'
alias vim='nvim'
alias cd='z'
alias gg='lazygit'

alias python='/usr/bin/python3'
alias pip='/usr/bin/pip3'

alias e="fzf --bind 'enter:become(\$EDITOR {})'"
alias dot="fd --hidden --exclude .git . \$HOME/dotfiles | e"
