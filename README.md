# How to use

## Install and symlink everything
```
make
```

This symlinks the dotfiles into `~` and installs:
- **Homebrew** — Package manager for macOS
- **GitHub CLI** — Command-line tool for GitHub
- **Oh My Zsh** — Zsh framework with plugins and themes
- **Powerlevel10k** — Modern zsh theme with instant prompt
- **Zsh plugins** — Syntax highlighting and autosuggestions
- **fzf** — Fuzzy reverse search (Ctrl-R) into `~/.fzf`
- **Nerdfont** — Meslo Nerd Font for terminal icons

Each can also be installed individually:
```bash
make homebrew        # Install Homebrew
make gh              # Install GitHub CLI
make oh-my-zsh       # Install Oh My Zsh
make powerlevel10k   # Install Powerlevel10k theme
make zsh-plugins     # Install zsh plugins
make fzf             # Install fzf
make nerdfont        # Install Meslo Nerd Font
make gh-auth         # Authenticate with GitHub
```

## Aliases and Functions

### Shell
- `cx [dir]` — Change directory and list (with Python venv activation if available)
- `gprune` — Prune all merged local and remote branches

### Git
- `git pom` — Pull origin main
- `git sync` — Checkout main, pull, return to feature branch, rebase against main
- `git co` — Checkout
- `git cm` — Commit
- `git cma` — Commit amend
- `git br` — Branch
- `git st` — Status
- `git lgl` — Log graph

## Terminal Setup

After installation, configure your terminal to use the Meslo Nerd Font:
1. Open Terminal or iTerm2 Preferences
2. Go to Profiles → Font
3. Select **Meslo LG M Nerd Font**

Powerlevel10k will auto-configure on first launch. Run `p10k configure` anytime to reconfigure the prompt.

## Remove symlinks
```
make clean
```
