#! /bin/bash

plug "zap-zsh/fzf"
eval "$(fzf --zsh)"

export FZF_DEFAULT_OPTS='--layout=reverse --no-border'
export FZF_COMPLETION_OPTS='--layout=reverse --no-border'
export FZF_DEFAULT_COMMAND='fd --hidden --no-ignore'
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'
# export FZF_COMPLETION_TRIGGER=".."

alias e="fzf --bind 'enter:become(\$EDITOR {})'"
alias dot="fd -t f --hidden --exclude .git . --base-directory \$HOME/dotfiles | fzf --preview 'cat \$HOME/dotfiles/{}' --bind 'enter:become(cd \$HOME/dotfiles; \$EDITOR {})'"

# # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)
      fzf --preview 'tree -C {} | head -200' "$@" ;;
    export|unset)
      fzf --preview "eval 'echo \$'{}" "$@" ;;
    ssh)
      fzf --preview 'dig {}' "$@" ;;
    note)
      fd -e md . --base-directory=$OBSIDIAN_VAULT_DIR/Notes -X ls -t |
        fzf "$@" --preview 'cat $OBSIDIAN_VAULT_DIR/Notes/{}';;
    meeting)
      fd -e md . --base-directory=$OBSIDIAN_VAULT_DIR/Notes -X ls -t |
        grep Meeting |
        fzf "$@" --preview 'cat $OBSIDIAN_VAULT_DIR/Notes/{}';;
    *)
      fzf;;

  esac
}
