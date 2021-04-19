# A subset of:
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh

alias g='git'

alias gaa='git add --all'
alias gap='git add -p'

alias gpristine='git reset --hard && git clean -dffx'
alias gcom='git checkout $(git_main_branch)'
alias gco='git checkout'

alias gb='git branch'
alias gbd='git branch -d'

alias gc='git commit -v'
alias gc!='git commit -v --amend'

alias gd='git diff'
alias gdca='git diff --cached'
alias gds='git diff --staged'

alias gl='git lines'
alias gs='git status'

alias grbi='git rebase -i'
alias grbim='git rebase -i $(git_main_branch)'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
