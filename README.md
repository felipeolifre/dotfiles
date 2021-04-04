# dotfiles

Files for configuring a terminal environment and other various system settings,
centered around macOS. Check out [this guide](https://dotfiles.github.io) to
dotfiles on GitHub for more info.

## Installation

```bash
$ git clone https://github.com/felipeolifre/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ make
$ make link
```

## Makefile

### `make`

-   Set up [Homebrew](https://brew.sh) and installs all packages defined in the
    [Brewfile](macOS/Brewfile).
-   Set up the latest available version for `Golang`, `Java`, `Node.js`,
    `Python` and `Terraform` system-wide using [asdf](https://asdf-vm.com/#/).
-   Set up the [pure](https://github.com/sindresorhus/pure) shell prompt.
-   Configures preferred system defaults defined in
    [`/macOS/defaults.sh`](macOS/defaults.sh).
-   Configures security and privacy settings defined in
    [`/macOS/security.sh`](macOS/security.sh).
-   Updates macOS.

### `make link`

-   Creates necessary symlinks for configuration files in the home directory
    using `ln` commands.
    > NOTE: Nothing new is installed to the machine, but files _may_ be
    > overwritten since the Makefile recipe passes the `-f` flag for every `ln`
    > command.
-   Run `make unlink` to remove these symlinks.

## Thanks To...

This seletion of dotfiles and system settings would not be possible without the
great examples and guidance provided by:

-   https://github.com/mathiasbynens/dotfiles
-   https://github.com/rootbeersoup/dotfiles
-   https://github.com/drduh/macOS-Security-and-Privacy-Guide
-   https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load.html
-   http://dotfiles.github.io/inspiration/
