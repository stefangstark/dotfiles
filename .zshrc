# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# dotfile management
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export PATH=$PATH:$HOME/bin:/usr/local/bin
export ZSH=$HOME/.dotfiles/zsh
export ADOTDIR=$ZSH/.antigen

autoload -U compinit && compinit
source $ZSH/antigen.zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen theme romkatv/powerlevel10k powerlevel10k
antigen apply

export TERM="xterm-256color"
export LS_COLORS="di=1;36:ln=1;97:or=1;31"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
alias ll='ls -lhG --color'


###############################################################
# => tmux
###############################################################
ts () { tmux attach -dt $1 || tmux new -s $1 }

###############################################################
# => auto complete 
###############################################################
setopt completealiases
autoload -U compinit && compinit
setopt SHARE_HISTORY
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)        # Include hidden files


###############################################################
# => history
###############################################################
HISTFILE=$HOME/.zhistory
SAVEHIST=10000
HISTSIZE=10000
setopt HIST_EXPIRE_DUPS_FIRST


###############################################################
# => command line editting 
###############################################################
bindkey -v
export KEYTIMEOUT=1
bindkey "^?" backward-delete-char

export VISUAL=vim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line


###############################################################
# => powerlevel10k
###############################################################
[[ ! -f $ZSH/.p10k.zsh ]] || source $ZSH/.p10k.zsh


###############################################################
# => zsh-history-substring-search
###############################################################
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=white,bold'

source ~/.dotfiles/zsh/local
