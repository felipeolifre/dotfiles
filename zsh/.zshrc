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

# Load NVM and NVM shell completion
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# Load pipx shell autocompletions
eval "$(register-python-argcomplete pipx)"

# Load rbenv automatically
eval "$(rbenv init - zsh)"

# Initialize `pure` prompt
promptinit
prompt pure

# Enable emacs keybindings
bindkey -e

# Set GPG teletypewriter
export GPG_TTY=$(tty)

# Initialize `direnv`
eval "$(direnv hook zsh)"

# bun completions
[ -s "/Users/felipe/.bun/_bun" ] && source "/Users/felipe/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
