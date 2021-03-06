# `.zshrc` is sourced in interactive shells. It should contain commands to set
# up aliases, functions, options, key bindings, etc.

# Set up aliases
source $DOTFILES/zsh/aliases

# Set up functions
FPATH=$DOTFILES/zsh/functions:$FPATH
autoload -Uz \
    bak \
    compinit \
    emailrep \
    fs \
    ipinfo \
    promptinit \
    stoken \
    timesh

# Enable Zsh completion system
compinit

# Enable Zsh autosuggestions and set suggestion strategy
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_STRATEGY=(completion history)

# Enable Zsh syntax highlighting 
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Initialize `pure` prompt
promptinit
prompt pure

# Add `asdf` to shell
source $(brew --prefix asdf)/asdf.sh

# Temporary workaround for https://github.com/asdf-vm/asdf/issues/428
ASDF_DIR=$(brew --prefix asdf)

# Set JAVA_HOME
source $HOME/.asdf/plugins/java/set-java-home.zsh

# Enable emacs keybindings
bindkey -e
