# Install packages and symlink files.

# List of files to symlink.
FILES := .bash_profile .bashrc .gitconfig .gitignore .tmux.conf .vimrc .zshrc

# Oh My Zsh directory.
ZSH_DIR := $(HOME)/.oh-my-zsh

# Fuzzy reverse search directory.
FZF_DIR := $(HOME)/.fzf

# Default target
.PHONY: install
install: symlink oh-my-zsh fzf

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
