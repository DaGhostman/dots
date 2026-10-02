# dots

Personal dotfiles, installed with [just](https://github.com/casey/just).

```sh
just            # check required tools & list recipes
just nvim       # ~/.config/nvim     -> nvim/
just git        # ~/.ssh/config      -> ssh/config, include git/.gitconfig
just ripgrep    # ~/.config/ripgrep  -> ripgrep/
just aliases    # hook aliases/ into bash, zsh or fish
```

> This repo is public. Never commit tokens, keys or passwords. Keep them in
> files outside the repo (see `.gitignore`).
