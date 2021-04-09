
# Pure Prompt
# https://github.com/sindresorhus/pure
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# ZSH Syntax Highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Global history
setopt inc_append_history
setopt share_history

[ ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh
[ ~/.zsh/aliases.zsh ] && source ~/.zsh/aliases.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
