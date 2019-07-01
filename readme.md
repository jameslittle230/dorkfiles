# Dorkfiles

In the interest of portability, I've decided to put my dotfiles on Github.
I've decided that my setup is good enough that I want to keep it fairly stable.
I call it Dorkfiles because this is a really dorky thing to do.

This git repository can live in the home directory.
The .gitignore is set up in such a way that it will ignore everything except the specified files; in this way, it acts as a whitelist.
To add new dotfiles, make sure to update the .gitignore file.

This is designed for macOS High Sierra, but works on Mojave and Catalina as well.

## Setting up a new computer

These dotfiles are also able to help when setting up a new computer.
The steps below should also help you out:

1. Install the XCode command line tools, which will give you Git, among other things.
2. Install [Homebrew](https://brew.sh).
3. Clone this repo to your home directory
	- It's not obvious how to clone a repository into a non-empty directory. The instructions [here (https://stackoverflow.com/a/18999726)](https://stackoverflow.com/a/18999726) help me every time.
4. Run `brew bundle` to install the software I use (Note: Haven't gotten around to testing these yet)
5. I use [`vim-plug`](https://github.com/junegunn/vim-plug) to manage my Vim plugins. Install it and run the plugin installation process.
6. In my Dropbox, there are other setup files for BetterTouchTool, Alfred, iTerm 3, among other things. Install all those in the right places.
