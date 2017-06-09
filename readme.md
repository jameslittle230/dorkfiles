# Dorkfiles

In the interest of portability, I've decided to put my dotfiles on Github.
I've decided that my setup is good enough that I want to keep it fairly stable.
I call it Dorkfiles because this is a really dorky thing to do.

This git repository can live in the home directory.
The .gitignore is set up in such a way that it will ignore everything except the specified files; in this way, it acts as a whitelist.
To add new dotfiles, make sure to update the .gitignore file.

This is designed for macOS Sierra.

## Setting up a new computer

These dotfiles are also able to help when setting up a new computer.
The steps below should also help you out:

1. Install the XCode command line tools, which will give you Git, among other things.
2. Install Homebrew and Homebrew Cask.
3. Run `< .brew xargs brew install` and `< .cask xargs brew cask install` to install the software I use (Note: Haven't gotten around to testing these yet)
4. I use vim-plug to manage my vim plugins. Install it and run the plugin installation process.
5. In my Dropbox, there are other setup files for BetterTouchTool, Alfred, iTerm 3, among other things. Install all those in the right places.

## Future work

I want to start using zsh and oh-my-zsh, but bash is working fine for me right now.
