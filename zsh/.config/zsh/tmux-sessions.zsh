#! /bin/sh

ts () { tmux attach -dt $1 || tmux new -s $1 }

# contextual tmux aliases
if [[ -e $(echo $TMUX | cut -f 1 -d,) ]]; then
    export TMUX_SESSION_NAME=$(tmux display-message -p '#S')
fi

if [[ -n $TMUX_SESSION_NAME ]]; then
    tmux_session_alias=${XDG_DATA_HOME:-$HOME}/tmux/envs/${TMUX_SESSION_NAME}
    [ -f $tmux_session_alias ] && source $tmux_session_alias
    [ -f $tmux_session_alias ] && HISTFILE=$ZDOTDIR/zhistory/${TMUX_SESSION_NAME}-history.zsh
fi
