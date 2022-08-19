# dotfiles
See: https://www.atlassian.com/git/tutorials/dotfiles

To set up on a new env run:
Add
```alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'``` to your rc file and run:

```
echo ".cfg" >> .gitignore
git clone --bare git@github.com:stefangstark/dotfiles.git $HOME/.cfg
config checkout
```
