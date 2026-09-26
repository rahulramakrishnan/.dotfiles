# Install packages and symlink files.

# List of files to symlink.
FILES := .bash_profile .bashrc .gitconfig .gitignore .tmux.conf .vimrc .zshrc

# Oh My Zsh directory.
ZSH_DIR := $(HOME)/.oh-my-zsh

# Fuzzy reverse search directory.
FZF_DIR := $(HOME)/.fzf

# Powerlevel10k theme directory.
P10K_DIR := $(ZSH_DIR)/custom/themes/powerlevel10k

# Zsh plugins directory.
ZSH_PLUGINS_DIR := $(ZSH_DIR)/custom/plugins

# Homebrew may not be on PATH yet (e.g. right after installing it), so look in
# the default Apple Silicon and Intel locations too. Recursive (=) so it is
# re-evaluated after the homebrew target has run.
BREW = $(shell command -v brew || ls /opt/homebrew/bin/brew /usr/local/bin/brew 2>/dev/null | head -1)

# Default target
.PHONY: install
install: homebrew gh symlink oh-my-zsh powerlevel10k zsh-plugins fzf nerdfont gh-auth

.PHONY: homebrew
homebrew:
	@if [ -z "$(BREW)" ]; then \
		echo "🍺 Homebrew not found. Installing..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
		echo "✅ Homebrew installed successfully."; \
	else \
		echo "⚡ Homebrew is already installed."; \
	fi

# GitHub CLI.
.PHONY: gh
gh: homebrew
	@if ! "$(BREW)" list gh >/dev/null 2>&1; then \
		echo "🐙 gh not found. Installing..."; \
		"$(BREW)" install gh && \
		echo "✅ gh installed successfully."; \
	else \
		echo "⚡ gh is already installed."; \
	fi

# Interactive: prompts for how to log in to GitHub. Skipped if already logged in.
.PHONY: gh-auth
gh-auth: gh
	@GH="$$(dirname "$(BREW)")/gh"; \
	if ! "$$GH" auth status >/dev/null 2>&1; then \
		echo "🔑 Logging in to GitHub..."; \
		"$$GH" auth login; \
	else \
		echo "⚡ gh is already logged in."; \
	fi

.PHONY: symlink
symlink:
	@echo "🚀 Starting dotfiles installation..."
	@for file in $(FILES); do \
		src="$(shell pwd)/$$file"; \
		target="$(HOME)/$$file"; \
		\
		if [ -e "$$target" ] && [ ! -L "$$target" ]; then \
			echo "⚠️  Backing up existing $$target to $$target.backup"; \
			mv "$$target" "$$target.backup"; \
		fi; \
		\
		ln -sf "$$src" "$$target"; \
		echo "✅ Linked $$src -> $$target"; \
	done

# Clone Oh My Zsh directly instead of running its install script, which
# would overwrite the symlinked .zshrc and try to change the login shell.
.PHONY: oh-my-zsh
oh-my-zsh:
	@if [ ! -d "$(ZSH_DIR)" ]; then \
		echo "🐚 Oh My Zsh not found. Cloning..."; \
		git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$(ZSH_DIR)" && \
		echo "✅ Oh My Zsh installed successfully."; \
	else \
		echo "⚡ Oh My Zsh is already installed."; \
	fi

# Powerlevel10k theme for oh-my-zsh
.PHONY: powerlevel10k
powerlevel10k: oh-my-zsh
	@if [ ! -d "$(P10K_DIR)" ]; then \
		echo "🎨 Powerlevel10k not found. Cloning..."; \
		git clone --depth 1 https://github.com/romkatv/powerlevel10k.git "$(P10K_DIR)" && \
		echo "✅ Powerlevel10k installed successfully."; \
	else \
		echo "⚡ Powerlevel10k is already installed."; \
	fi

# Zsh plugins: zsh-syntax-highlighting and zsh-autosuggestions
.PHONY: zsh-plugins
zsh-plugins: oh-my-zsh
	@echo "📦 Installing zsh plugins..."; \
	if [ ! -d "$(ZSH_PLUGINS_DIR)/zsh-syntax-highlighting" ]; then \
		git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$(ZSH_PLUGINS_DIR)/zsh-syntax-highlighting" && \
		echo "✅ zsh-syntax-highlighting installed."; \
	else \
		echo "⚡ zsh-syntax-highlighting is already installed."; \
	fi; \
	if [ ! -d "$(ZSH_PLUGINS_DIR)/zsh-autosuggestions" ]; then \
		git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git "$(ZSH_PLUGINS_DIR)/zsh-autosuggestions" && \
		echo "✅ zsh-autosuggestions installed."; \
	else \
		echo "⚡ zsh-autosuggestions is already installed."; \
	fi

# fzf (the Go version). The --bin flag downloads the prebuilt binary but
# DOES NOT touch your config files; shell integration lives in .zshrc/.bashrc.
.PHONY: fzf
fzf:
	@if [ ! -d "$(FZF_DIR)" ]; then \
		echo "🔍 FZF not found. Cloning and installing..."; \
		git clone --depth 1 https://github.com/junegunn/fzf.git "$(FZF_DIR)" && \
		"$(FZF_DIR)/install" --bin && \
		echo "✅ FZF installed successfully."; \
	else \
		echo "⚡ FZF is already installed."; \
	fi

# Nerdfont for terminal icons (Meslo Nerd Font)
.PHONY: nerdfont
nerdfont: homebrew
	@if ! "$(BREW)" list font-meslo-lg-nerd-font >/dev/null 2>&1; then \
		echo "🔤 Nerdfont not found. Installing via Homebrew..."; \
		"$(BREW)" install --cask font-meslo-lg-nerd-font && \
		echo "✅ Nerdfont installed successfully. Set your terminal font to 'Meslo LG M Nerd Font'."; \
	else \
		echo "⚡ Nerdfont is already installed."; \
	fi

.PHONY: clean
clean:
	@echo "Cleaning up symlinks..."
	@for file in $(FILES); do \
		target="$(HOME)/$$file"; \
		if [ -L "$$target" ]; then \
			rm "$$target"; \
			echo "🗑️  Removed link $$target"; \
		fi; \
	done
