# dotfiles
See: https://www.atlassian.com/git/tutorials/dotfiles

To set up on a new env run:
Add
```alias config='/usr/bin/git --git-dir=$HOME/.config-starks-dotfiles/ --work-tree=$HOME'``` to your rc file and run:

```
echo ".config-starks-dotfiles" >> .gitignore
git clone --bare git@github.com:stefangstark/dotfiles.git $HOME/.config-starks-dotfiles
config checkout
```

For `vim` packages run
```
vim +PluginInstall +qall
```
