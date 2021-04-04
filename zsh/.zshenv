# `.zshenv` is sourced on all invocations of the shell, unless the `-f` option
# is set. It should contain commands to set the command search path, plus other
# important environment variables.
# `.zshenv` should not contain commands that produce output or assume the shell
# is attached to a tty.

###############################################################################
# Command Search Path                                                         #
###############################################################################

# Load Node global installed binaries
PATH="$HOME/.node/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

###############################################################################
# Other Environment Variables                                                 #
###############################################################################

# Dotfiles location
export DOTFILES=$HOME/.dotfiles

# Preferred editor
export EDITOR="vim"

# Manually set language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Prevent Homebrew redirecting from secure HTTPS to insecure HTTP
export HOMEBREW_NO_INSECURE_REDIRECT=1

# Require all Homebrew casks to have a checksum
export HOMEBREW_CASK_OPTS=--require-sha
