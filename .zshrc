# Pure Prompt
# https://github.com/sindresorhus/pure
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# ZSH Syntax Highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting
test -e "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" && source "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Git Completion
# https://medium.com/@oliverspryn/adding-git-completion-to-zsh-60f3b0e7ffbc
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit

# Global history
setopt inc_append_history
setopt share_history

# Automatically ls when cd-ing
auto-ls () {
	emulate -L zsh;
    ls
}
chpwd_functions=( auto-ls $chpwd_functions )

[ ~/.zsh/git.plugin.zsh ] && source ~/.zsh/git.plugin.zsh
[ ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh
[ ~/.zsh/aliases.zsh ] && source ~/.zsh/aliases.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zsh/local.zsh ] && source ~/.zsh/local.zsh

