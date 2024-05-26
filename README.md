## Installing

You will need `git` and GNU `stow`

Clone into your `$HOME` directory or `~`

```bash
git clone https://github.com/stefangstark/dotfiles.git ~/.dotfiles
```

Run `stow` to symlink everything or just select what you want

```bash
stow */ # Everything (the '/' ignores the README)
```

```bash
stow zsh # Just my zsh config
```

MacOS

All of my packages for MacOS can be found in `brew/.Brewfile`

- Install

```
stow ~/.dotfiles/brew

brew bundle --global
```
