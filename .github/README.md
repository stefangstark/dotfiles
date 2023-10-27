# dotfiles
See: https://www.atlassian.com/git/tutorials/dotfiles

To set up on a new env run:
Add
```alias config='/usr/bin/git --git-dir=$HOME/.repo-configs/ --work-tree=$HOME'``` to your rc file and run:

```
echo ".repo-configs" >> .gitignore
git clone --bare git@github.com:stefangstark/dotfiles.git $HOME/.repo-configs
config checkout
config config --local status.showUntrackedFiles no
```

## Setting up nvim
For now I am using NvChad, it has a lot of out-of-the-box functionality for neovim, but hard to share across envs. You need to install and then copy `.config/nvim/lua/custom` over from local
