fish_add_path /opt/homebrew/bin/

functions -e fish_right_prompt
zoxide init fish | source
starship init fish | source

function mkg
    mkdir -p $argv[1] && cd $argv[1]
end

function gco
    git checkout (git branch --all | fzf | tr -d '[:space:]')
end

abbr -a vim nvim
abbr -a ls exa -hl --git
abbr -a cd z

abbr -a gcob git checkout -b
abbr -a gp git pull
abbr -a gpush git push
abbr -a gs git status

if test -e config.local.fish
    source config.local.fish
end