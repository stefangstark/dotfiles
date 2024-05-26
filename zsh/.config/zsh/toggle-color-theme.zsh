#! /usr/bin/env bash

switch_vim_theme() {
  theme_for_vim_panes="$1"
  tmux list-panes -a -F '#{pane_id} #{pane_current_command}' |
    grep vim | # this captures vim and nvim
    cut -d ' ' -f 1 |
    xargs -I PANE tmux send-keys -t PANE ESCAPE \
      ":set background=${theme_for_vim_panes}" ENTER
}

toggle-color-theme-iterm2()  {
  case "$ITERM_PROFILE" in
    Default)
      export ITERM_PROFILE=light
      # tmux setenv -g ITERM_PROFILE $ITERM_PROFILE
      if [[ -z "$TMUX" ]]; then
        echo -ne "\033]50;SetProfile=$ITERM_PROFILE\007"
      else
        echo -ne "\ePtmux;\e\033]50;SetProfile=$ITERM_PROFILE\007\e\\"
        tmux source-file ~/.config/tmux/colorscheme-light.conf
        switch_vim_theme light
      fi
      ;;

    *)
      export ITERM_PROFILE=Default
      if [[ -z "$TMUX" ]]; then
        echo -ne "\033]50;SetProfile=$ITERM_PROFILE\007"
      else
        echo -ne "\ePtmux;\e\033]50;SetProfile=$ITERM_PROFILE\007\e\\"
        tmux source-file ~/.config/tmux/colorscheme-dark.conf
        switch_vim_theme dark
      fi
    ;;

  esac
}

zle -N toggle-color-theme toggle-color-theme-iterm2
bindkey "^]" toggle-color-theme
