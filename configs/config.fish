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
abbr -a ga git add
abbr -a gc git commit
abbr -a gcam git commit -am
abbr -a gcm git commit -m
abbr -a gs git status
abbr -a gd git diff
abbr -a gl git lines
abbr -a gp git push
abbr -a gpf git push --force
abbr -a gmaster git fm
abbr -a gmain git fmn
abbr -a gcob git checkout -b
abbr -a !! --position anywhere --function last_history_item

if test -e config.local.fish
    source config.local.fish
end