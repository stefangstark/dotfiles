# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set editor
export EDITOR=lvim
export VISUAL="$EDITOR"

# export TERM="xterm-256color"
export LS_COLORS="di=1;36:ln=1;97:or=1;31"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


###############################################################
# => management
###############################################################
alias config='/usr/bin/git --git-dir=$HOME/.config-repo/ --work-tree=$HOME'

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/Users/starks/.local/bin:${HOME}/.cargo/bin:$PATH
export CFG=$HOME/.config
export ADOTDIR=$CFG/zsh/.antigen

###############################################################
# => antigen installs
###############################################################

source $CFG/zsh/antigen.zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen theme romkatv/powerlevel10k powerlevel10k
antigen apply

###############################################################
# => tmux
###############################################################
ts () { tmux attach -dt $1 || tmux new -s $1 }

# contextual tmux aliases
if [[ -e $(echo $TMUX | cut -f 1 -d,) ]]; then
    export TMUX_SESSION_NAME=$(tmux display-message -p '#S')
fi

if [[ -n $TMUX_SESSION_NAME ]]; then
    tmux_session_alias=$CFG/tmux/envs/$TMUX_SESSION_NAME
    [ -f $tmux_session_alias ] && source $tmux_session_alias
fi

alias code='cd "${CODEDIR}"'

###############################################################
# => alisases
###############################################################
alias ga='git add'
alias gc='git commit -m'
alias gs='git status'
alias ll='ls -lhG --color=auto'
alias vim='nvim'

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
[[ ! -f $CFG/zsh/.p10k.zsh ]] || source $CFG/zsh/.p10k.zsh


###############################################################
# => zsh-history-substring-search
###############################################################
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=white,bold'
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1


################################################################
# => direnv 
################################################################
eval "$(direnv hook zsh)"
export DIRENV_LOG_FORMAT=

[ -f .envrc ] && direnv reload

autoload -Uz bashcompinit && bashcompinit


################################################################
# => set local opts
################################################################

[[ -f $CFG/zsh/local.zsh ]] && source $CFG/zsh/local.zsh

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

if [ -f "/Users/starks/software/anaconda/etc/profile.d/mamba.sh" ]; then
    . "/Users/starks/software/anaconda/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

