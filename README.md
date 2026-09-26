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
- **fzf** — Fuzzy reverse search (Ctrl-R)
- **fd** — Fast alternative to find command
- **tmux** — Terminal multiplexer with session persistence
- **Tmux Plugin Manager** — Plugin support for tmux (resurrection, continuum)
- **Nerdfont** — Meslo Nerd Font for terminal icons

Each can also be installed individually:
```bash
make homebrew        # Install Homebrew
make gh              # Install GitHub CLI
make oh-my-zsh       # Install Oh My Zsh
make powerlevel10k   # Install Powerlevel10k theme
make zsh-plugins     # Install zsh plugins
make fzf             # Install fzf
make fd              # Install fd (fast find)
make tmux            # Install tmux
make tpm             # Install Tmux Plugin Manager
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

## Tmux Configuration

The `.tmux.conf` includes:
- **Ctrl-A prefix** instead of Ctrl-B
- **Vim-style pane navigation** (j, k, h, l)
- **Mouse support** for selecting panes and resizing
- **256-color support** for better terminal appearance

### Tmux Plugins (with automatic session persistence)

- **tmux-resurrect** — Save/restore sessions manually
  - Save session: `<prefix> + Ctrl-s`
  - Restore session: `<prefix> + Ctrl-r`

- **tmux-continuum** — Automatic session backup and restoration
  - Saves session every 15 minutes automatically
  - Restores last session when tmux starts
  - Restore specific sessions with: `tmux kill-server && tmux` to force restore

### Setup Tmux Plugins

After running `make tpm`:
1. Open tmux: `tmux`
2. Press `<prefix> + I` (Shift+I) to install plugins automatically
3. Sessions will be saved automatically every 15 minutes
4. Sessions restore automatically when tmux starts

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
