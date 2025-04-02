#! /bin/bash

export PATH="/bin:$HOME/.local/bin:$PATH"
export ZHISTDIR="$HOME/.zhistory"
export HISTFILE="$ZHISTDIR/zhistory.zsh"
SAVEHIST=10000
HISTSIZE=10000
setopt HIST_EXPIRE_DUPS_FIRST

export EDITOR=nvim
export VISUAL="$EDITOR"
export IPYTHONDIR="$HOME/.config/.ipython/"

eval "$(fnm env --use-on-cd)"
eval "$(zoxide init zsh)"

eval "$(direnv hook zsh)"
export DIRENV_LOG_FORMAT=
[ -f .envrc ] && direnv reload

# use neovim as manpager
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
