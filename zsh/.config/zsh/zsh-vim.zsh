bindkey -v
export KEYTIMEOUT=1
bindkey "^?" backward-delete-char

export VISUAL=vim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line


