# Install packages and symlink files.

# List of files to symlink.
FILES := .bash_profile .bashrc .gitconfig .gitignore .tmux.conf .vimrc .zshrc

# Fuzzy reverse search directory.
FZF_DIR := $(HOME)/.fzf

# Default target
.PHONY: install
install: symlink fzf

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

.PHONY: fzf
fzf:
	@if [ ! -d "$(FZF_DIR)" ]; then \
		echo "🔍 FZF not found. Cloning and installing..."; \
		git clone --depth 1 https://github.com/junegunn/fzf.git $(FZF_DIR); \
		# --bin flag installs the binary but DOES NOT touch your config files
		$(FZF_DIR)/install --bin; \
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
