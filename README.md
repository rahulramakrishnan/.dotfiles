# How to use

## Install and symlink everything
```
make
```

This symlinks the dotfiles into `~` and installs:
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) into `~/.oh-my-zsh`
- [fzf](https://github.com/junegunn/fzf) (fuzzy reverse search, Ctrl-R) into `~/.fzf`

Each can also be installed on its own with `make oh-my-zsh` or `make fzf`.

## Remove symlinks
```
make clean
```
