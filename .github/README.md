# dotfiles
See: https://www.atlassian.com/git/tutorials/dotfiles

To set up on a new env run:
To your rc/profile file add:

```
alias config='/usr/bin/git --git-dir=$HOME/.repo-configs/ --work-tree=$HOME'
```

And then run:

```
echo ".config-repo" >> .gitignore
git clone --bare git@github.com:stefangstark/dotfiles.git $HOME/.config-repo
config checkout
config config --local status.showUntrackedFiles no
```

## Install zsh package manager
[antigen](https://github.com/zsh-users/antigen)
```
curl -L git.io/antigen > .config/zsh/antigen.zsh
```



## Setting up nvim
For now I am using NvChad, it has a lot of out-of-the-box functionality for neovim, but hard to share across envs. You need to install and then copy `.config/nvim/lua/custom` over from local
