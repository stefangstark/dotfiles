# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:/usr/local/bin:$PATH

setopt completealiases
autoload -U compinit && compinit
setopt SHARE_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=10000
HISTSIZE=10000
setopt HIST_EXPIRE_DUPS_FIRST
export TERM="xterm-256color"

# Basic auto/tab complete:
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)        # Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey "^?" backward-delete-char

alias ll='ls -lhG'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export ZSH=$HOME/.dotfiles/zsh

source $ZSH/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f $ZSH/.p10k.zsh ]] || source $ZSH/.p10k.zsh

source $ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/zsh-history-substring-search/zsh-history-substring-search.zsh

export PATH="/Users/starks/software/anaconda/bin:${PATH}"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/starks/software/anaconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/starks/software/anaconda/etc/profile.d/conda.sh" ]; then
        . "/Users/starks/software/anaconda/etc/profile.d/conda.sh"
    else
        export PATH="/Users/starks/software/anaconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
