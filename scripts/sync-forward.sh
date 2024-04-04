#!/bin/bash

touch ~/.hushlogin

# mkdir -p ~/.config/fish
mkdir -p ~/.config/nvim/

cp ${BASH_SOURCE%/*}/../configs/config.fish ~/.config/fish/config.fish
cp ${BASH_SOURCE%/*}/../configs/starship.toml ~/.config/starship.toml
cp ${BASH_SOURCE%/*}/../configs/git/gitconfig ~/.gitconfig
cp ${BASH_SOURCE%/*}/../configs/git/gitignore ~/.gitignore
cp ${BASH_SOURCE%/*}/../configs/git/git-commit-template ~/.git-commit-template
cp ${BASH_SOURCE%/*}/../configs/init.vim ~/.config/nvim/init.vim