#! /bin/bash 
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/tmux-sessions.zsh"
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/functions.zsh"
plug "$HOME/.config/zsh/zsh-vim.zsh"
plug "$HOME/.config/zsh/toggle-color-theme.zsh"
plug "$HOME/.config/zsh/fzf.zsh"

plug "$HOME/.config/zsh/buffer-complete-and-history.zsh"

plug "romkatv/powerlevel10k"
[ -f "$HOME/.config/zsh/p10k.zsh" ] &&
  source "$HOME/.config/zsh/p10k.zsh"

activate_venv_on_cd() {
    local venv_dir=".venv"
    if [[ -d "$PWD/$venv_dir" ]]; then
        source "$PWD/$venv_dir/bin/activate"
    else
      [[ ! -z $VIRTUAL_ENV ]] && deactivate
    fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd activate_venv_on_cd
