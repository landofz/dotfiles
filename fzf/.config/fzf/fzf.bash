# General settings
# ----------------
export FZF_DEFAULT_COMMAND='ag --files-with-matches --hidden --follow'

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/lib/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
[[ -s "$HOME/lib/fzf/shell/key-bindings.bash" ]] && source "$HOME/lib/fzf/shell/key-bindings.bash"
bind -x '"\C-p": nvim $(fzf);'
