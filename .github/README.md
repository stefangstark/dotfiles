# dotfiles
See: https://www.atlassian.com/git/tutorials/dotfiles

To set up on a new env run:
To your rc/profile file add:

```
alias config='/usr/bin/git --git-dir=$HOME/.config-repo/ --work-tree=$HOME'
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


## Install brew packages
probably better ways to do this ... 
- I keep simple things in `.config/brew-formulae.txt`
- install jetbrains with [nerd fonts](https://www.nerdfonts.com/font-downloads)

## Install lunarvim
