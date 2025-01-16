# dotfiles

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

## Fresh set up
see [here](https://www.chrisatmachine.com/posts/01-macos-developer-setup)

- set up github `ssh` keys
  - [create](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) key
  - [add](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) to github
- clone this repo
  - install `brew`
  - install `stow`
  - set up dotfiles with `stow`
- 
