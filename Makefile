DOTDIR := $(shell echo $(HOME)/.dotfiles)

.PHONY: macos brew dev prompt link unlink

macos: brew dev prompt
	bash $(DOTDIR)/macOS/defaults.sh
	bash $(DOTDIR)/macOS/security.sh
	softwareupdate --install --all

brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	export HOMEBREW_NO_INSECURE_REDIRECT=1
	export HOMEBREW_CASK_OPTS=--require-sha
	brew update
	brew bundle --file=$(DOTDIR)/macOS/Brewfile

dev:
	asdf plugin add golang
	asdf plugin add java
	asdf plugin add nodejs
	asdf plugin add python
	asdf plugin add terraform
	asdf install golang latest
	asdf install java $(asdf list-all java | grep  openjdk | tail -n 1)
	asdf install nodejs latest
	asdf install python latest
	asdf install terraform latest
	asdf global golang $(asdf list golang)
	asdf global java $(asdf list java)
	asdf global nodejs $(asdf list nodejs)
	asdf global python $(asdf list python)
	asdf global terraform $(asdf list terraform)

prompt:
	exec zsh
	npm install --global pure-prompt

link:
	ln -sf $(DOTDIR)/.curlrc $(HOME)/.curlrc
	ln -sf $(DOTDIR)/.mackup.cfg $(HOME)/.mackup.cfg
	ln -sf $(DOTDIR)/.vimrc $(HOME)/.vimrc
	ln -sf $(DOTDIR)/.wgetrc $(HOME)/.wgetrc
	ln -sf $(DOTDIR)/aws $(HOME)/.aws
	ln -sf $(DOTDIR)/git/.gitconfig $(HOME)/.gitconfig
	ln -sf $(DOTDIR)/git/.gitignore $(HOME)/.gitignore
	ln -sf $(DOTDIR)/kitty/kitty.conf $(HOME)/.config/kitty/kitty.conf
	ln -sf $(DOTDIR)/ssh/config $(HOME)/.ssh/config
	ln -sf $(DOTDIR)/zsh/.zshenv $(HOME)/.zshenv
	ln -sf $(DOTDIR)/zsh/.zshrc $(HOME)/.zshrc

unlink:
	unlink $(HOME)/.curlrc
	unlink $(HOME)/.mackup.cfg
	unlink $(HOME)/.vimrc
	unlink $(HOME)/.wgetrc
	unlink $(HOME)/.aws
	unlink $(HOME)/.gitconfig
	unlink $(HOME)/.gitignore
	unlink $(HOME)/.config/kitty/kitty.conf
	unlink $(HOME)/.ssh/config
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
