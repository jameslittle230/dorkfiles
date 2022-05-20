fish_add_path /opt/homebrew/bin/
fish_add_path ~/.cargo/bin

set -gx EDITOR nvim

functions -e fish_right_prompt
zoxide init fish | source
starship init fish | source

function mkg
    mkdir -p $argv[1] && cd $argv[1]
end

function gco
    if count $argv > /dev/null
        git checkout $argv
    else
        git checkout (git branch | fzf | tr -d '[:space:]')
    end
end

abbr -a vim nvim
abbr -a ls exa -hl --git
abbr -a cd z
abbr -a c code --new-window .

abbr -a gcob git checkout -b
abbr -a gp git pull
abbr -a gpush git push
abbr -a gs git status
abbr -a gict gh issue create -t
abbr -a gwip git commit -am \"WIP\"

if test -e config.local.fish
    source config.local.fish
end
