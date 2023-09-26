# General settings
# ----------------
export FZF_DEFAULT_COMMAND='ag --files-with-matches --hidden --follow'

# Auto-completion
# ---------------
if [[ $- == *i* ]]; then
    if [[ -s "$HOME/.nix-profile/share/fzf/completion.bash" ]]; then
        source "$HOME/.nix-profile/share/fzf/completion.bash" 2> /dev/null
    elif [[ -s "/usr/share/fzf/completion.bash" ]]; then
        source "/usr/share/fzf/completion.bash" 2> /dev/null
    elif [[ -s "$HOME/lib/fzf/src/shell/completion.bash" ]]; then
        source "$HOME/lib/fzf/src/shell/completion.bash" 2> /dev/null
    fi
fi

# Key bindings
# ------------
if [[ -s "$HOME/.nix-profile/share/fzf/key-bindings.bash" ]]; then
    source "$HOME/.nix-profile/share/fzf/key-bindings.bash"
elif [[ -s "/usr/share/fzf/key-bindings.bash" ]]; then
    source "/usr/share/fzf/key-bindings.bash"
else
    [[ -s "$HOME/lib/fzf/src/shell/key-bindings.bash" ]] && source "$HOME/lib/fzf/src/shell/key-bindings.bash"
fi
bind -x '"\C-p": nvim $(fzf);'
