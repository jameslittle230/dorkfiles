# FZF
export FZF_DEFAULT_COMMAND="rg --files --color always --hidden --glob '!{node_modules/*,.git/*}'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"

# Editor
export EDITOR=nvim
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# Path
export PATH="/opt/homebrew/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"