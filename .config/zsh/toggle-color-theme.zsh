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
      tmux source-file ~/.config/tmux/colorscheme-light.conf
      switch_vim_theme light
      ;;
    *)
      export ITERM_PROFILE=Default
      tmux source-file ~/.config/tmux/colorscheme-dark.conf
      switch_vim_theme dark
    ;;

  esac
  if ! { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } then
    echo -ne "\ePtmux;\e\033]50;SetProfile=$ITERM_PROFILE\007\e\\"
  else
    echo -ne "\033]50;SetProfile=$ITERM_PROFILE\007"
  fi
}

zle -N toggle-color-theme toggle-color-theme-iterm2
bindkey "^]" toggle-color-theme
