# `.zshenv` is sourced on all invocations of the shell, unless the `-f` option
# is set. It should contain commands to set the command search path, plus other
# important environment variables.
# `.zshenv` should not contain commands that produce output or assume the shell
# is attached to a tty.

###############################################################################
# Command Search Path                                                         #
###############################################################################

# Add third-party functions to FPATH
export FPATH="/opt/homebrew/share/zsh/site-functions:$FPATH"

###############################################################################
# Other Environment Variables                                                 #
###############################################################################

# Dotfiles location
export DOTFILES="$HOME/.dotfiles"

# Preferred editor
export EDITOR="vim"

# Manually set language environment
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# Prevent Homebrew redirecting from secure HTTPS to insecure HTTP
export HOMEBREW_NO_INSECURE_REDIRECT=1

# Require all Homebrew casks to have a checksum
export HOMEBREW_CASK_OPTS=--require-sha

# Disable Homebrew hints
export HOMEBREW_NO_ENV_HINTS=1

# Set NVM working directory
export NVM_DIR="$HOME/.nvm"

# Disable Zsh session history
export ZSH_DISABLE_SESSION_HISTORY=1
