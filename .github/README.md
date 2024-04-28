# dotfiles
See: https://www.atlassian.com/git/tutorials/dotfiles

To set up on a new env run:
Run:

```
alias config='/usr/bin/git --git-dir=$HOME/.config-repo/ --work-tree=$HOME'
```

And then run:

```
git clone --bare git@github.com:stefangstark/dotfiles.git $HOME/.config-repo
config checkout
config config --local status.showUntrackedFiles no
```
