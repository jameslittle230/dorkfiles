#!/bin/bash

source ./cli-utils.sh

if test ! $(which brew); then
    echo "Installing homebrew"

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    brew update
fi

brew install eza # ls replacement
brew install zoxide # cd replacement
brew install bat # cat replacement
brew install starship # prompt
brew install fish # shell

brew install fzf
brew install ripgrep
brew install difft

