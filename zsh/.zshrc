#! /bin/sh

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/tmux-sessions.zsh"
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/functions.zsh"
plug "$HOME/.config/zsh/zsh-vim.zsh"
plug "$HOME/.config/zsh/toggle-color-theme.zsh"

plug "esc/conda-zsh-completion"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
# plug "zap-zsh/supercharge"

plug "romkatv/powerlevel10k"
[ -f "$HOME/.config/zsh/p10k.zsh" ] && source "$HOME/.config/zsh/p10k.zsh"

if command -v bat &> /dev/null; then
  alias cat="bat -pp --theme \"Nord\""
  alias catt="bat --theme \"Nord\""
fi

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bold'
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
