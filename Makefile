DOTDIR := $(shell echo $(HOME)/.dotfiles)
NVM_DIR := $(HOME)/.nvm

.PHONY: macos brew pipx uv python nvm bun pai prompt link unlink

macos: brew pipx uv python nvm prompt
	bash $(DOTDIR)/macOS/defaults.sh
	bash $(DOTDIR)/macOS/security.sh
	softwareupdate --install --all

# === Homebrew installation ===
brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	export HOMEBREW_NO_INSECURE_REDIRECT=1
	export HOMEBREW_CASK_OPTS=--require-sha
	brew update
	brew bundle --file=$(DOTDIR)/macOS/Brewfile

# === pipx installation ===
pipx:
	pipx ensurepath; \
	sudo pipx ensurepath --global || true

# === uv setup (installed via pipx) ===
uv:
	pipx install uv

# === Python installation (via uv) ===
python: uv
	@echo "Installing default Python via uv..."
	# Install latest Python if not already installed
	@if ! uv list | grep -q '^python '; then \
		uv install python latest; \
	fi
	uv use python latest
	@echo "Python version now active: $$(python3 --version)"

# === NVM installation ===
nvm:
	@echo "Installing or updating NVM to the latest release..."
	@LATEST=$$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/'); \
	if [ ! -d "$(NVM_DIR)" ]; then \
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$$LATEST/install.sh | bash; \
	else \
		cd $(NVM_DIR) && git fetch --tags origin && git checkout v$$LATEST; \
	fi
	@echo "NVM installed at $(NVM_DIR)"

# === bun installation ===
bun:
	curl -fsSL https://bun.sh/install | bash

# === Personal AI Infrastructure (PAI) setup ===
pai: bun
	git clone https://github.com/danielmiessler/PAI.git ~/.claude
	bun run ~/.claude/.claude/tools/setup/setup.ts \
		--pai-dir ~/.claude \
		--name "Felipe Olivera" \
		--email 11680328+felipeolifre@users.noreply.github.com \
		--assistant-name "Sophia" \
		--force

# === Prompt setup ===
prompt:
	exec zsh
	npm install --global pure-prompt

# === Symlink configuration ===
link:
	ln -sf $(DOTDIR)/.curlrc $(HOME)/.curlrc
	ln -sf $(DOTDIR)/.vimrc $(HOME)/.vimrc
	ln -sf $(DOTDIR)/.wgetrc $(HOME)/.wgetrc
	ln -sf $(DOTDIR)/aws/cli/alias $(HOME)/.aws/cli/alias
	ln -sf $(DOTDIR)/git/.gitconfig $(HOME)/.gitconfig
	ln -sf $(DOTDIR)/git/.gitignore $(HOME)/.gitignore
	ln -sf $(DOTDIR)/ssh/config $(HOME)/.ssh/config
	ln -sf $(DOTDIR)/vscode/settings.json $(HOME)/Library/Application\ Support/Code/User/settings.json
	ln -sf $(DOTDIR)/zsh/.zshenv $(HOME)/.zshenv
	ln -sf $(DOTDIR)/zsh/.zshrc $(HOME)/.zshrc

unlink:
	unlink $(HOME)/.curlrc
	unlink $(HOME)/.vimrc
	unlink $(HOME)/.wgetrc
	unlink $(HOME)/.aws/cli/alias
	unlink $(HOME)/.gitconfig
	unlink $(HOME)/.gitignore
	unlink $(HOME)/.ssh/config
	unlink $(HOME)/Library/Application\ Support/Code/User/settings.json
	unlink $(HOME)/.zshenv
	unlink $(HOME)/.zshrc
	@printf "\\033[32m✓\\033[0m Symlinks removed. Manually remove ~/.dotfiles directory if needed.\\n"

.PHONY: help usage
.SILENT: help usage

help: usage

usage:
	printf "\\n\
	\\033[1mDOTFILES\\033[0m\\n\
	\\n\
	Custom settings and configurations for macOS.\\n\
	See README.md for detailed usage information.\\n\
	\\n\
	\\033[1mUSAGE:\\033[0m make [target]\\n\
	\\n\
	  make         Install all configurations and applications.\\n\
	\\n\
	  make link    Symlink only Zsh and Vim configurations to the home directory.\\n\
	\\n\
	  make unlink  Remove symlinks created by \`make link\`.\\n\
	\\n\
	"
