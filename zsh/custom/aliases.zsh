alias rosetta="arch -x86_64"

function mkg() {
    mkdir -p $@ && cd ${@:$#}
}

function gco() {
    git checkout "$(git branch --all | fzf | tr -d '[:space:]')"
}

alias ls="exa -hl --git"
alias lal="ls -al"
alias vim="nvim"
alias c..="cd .."
alias c...="cd ../.."
alias c....="cd ../../../"
