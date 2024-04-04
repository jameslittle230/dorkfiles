fish_add_path /opt/homebrew/bin/
fish_add_path ~/.cargo/bin

set -gx EDITOR nvim

functions -e fish_right_prompt
functions -e fish_greeting
zoxide init fish | source
starship init fish | source

function mkg
    mkdir -p $argv[1] && cd $argv[1]
end

function gco
    if count $argv > /dev/null
        git checkout $argv
    else
        git checkout (git branch | fzf --height 40% --border | tr -d '[:space:]')
    end
end

function last_history_item
    echo $history[1]
end

abbr -a cat bat
abbr -a cd z
abbr -a ls eza -1lTo --level=3 --group-directories-first --no-permissions --git
abbr -a c code --new-window .
abbr -a vim nvim
abbr -a g git
abbr -a gcob git checkout -b
abbr -a !! --position anywhere --function last_history_item

if test -e config.local.fish
    source config.local.fish
end