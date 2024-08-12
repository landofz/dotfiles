# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't record duplicate commands and ones starting with space
HISTCONTROL='erasedups:ignoreboth'
# don't record one and two letter commands
HISTIGNORE=?:??
# append to history file, don't overwrite
shopt -s histappend
# save multi-line commands as one command
shopt -s cmdhist
# big history
HISTSIZE=999999
HISTFILESIZE=999999
# immediately record all commands
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
# shorten \w and \W escapes
PROMPT_DIRTRIM=5

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize

# smart cd command
shopt -s autocd
# autocorrect minor spelling errors
shopt -s dirspell
shopt -s cdspell
# use vars as cd destinations
shopt -s cdable_vars
export dotfiles=$HOME/dotfiles

# make less more friendly for non-text input files, see lesspipe(1)
if command -v lesspipe.sh > /dev/null; then eval "$(SHELL=/bin/sh lesspipe.sh)"; fi

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# enable color support of ls and also add handy aliases
if command -v dircolors > /dev/null; then
    if [[ -r $HOME/.config/dircolors ]]; then
        eval "$(dircolors -b $HOME/.config/dircolors)"
    else
        eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if command -v exa > /dev/null; then
    alias ll='exa -lg'
    alias la='exa -a'
    alias lt='exa --tree'
else
    alias ll='ls -lg'
    alias la='ls -a'
fi
alias l='ls -CF'

# alias cp='cp -i'
# alias mv='mv -i'
# alias rm='rm -i'

if [[ -f $HOME/.nix-profile/share/bash-completion/bash_completion ]]; then
    . $HOME/.nix-profile/share/bash-completion/bash_completion
fi
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
fi

export EDITOR=nvim
export VISUAL="$EDITOR"
export BROWSER=browser.sh
export LESS='--quit-if-one-screen --ignore-case --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
export PAGER=less
# export WORKON_HOME=$HOME/virtualenv

[[ -s $HOME/lib/up/up.sh ]] && source "$HOME/lib/up/up.sh"
#[[ -s $HOME/.local/bin/virtualenvwrapper.sh ]] && source "$HOME/.local/bin/virtualenvwrapper.sh"
#[[ -s $HOME/bash-powerline.sh ]] && source "$HOME/bash-powerline.sh"
if command -v starship > /dev/null; then
    eval "$(starship init bash)"
fi
[[ -s $HOME/.config/fzf/fzf.bash ]] && source "$HOME/.config/fzf/fzf.bash"
[[ -s $HOME/lib/goto/goto.sh ]] && source "$HOME/lib/goto/goto.sh"

alias gnvim='NVIM_TUI_ENABLE_TRUE_COLOR= nvim-wrapper'
alias psvim='ps aux | grep -v grep | grep vim'
alias psbg='ps aux | grep "pts/[0-9]\+ \+T" | grep -v grep'
alias psfg='ps aux | grep pts | grep -v "[/-]bash$" | grep "+" | grep -v tmux | grep -v grep | grep -v "ps aux"'
alias psall='echo "--- BG ---"; psbg; echo "--- FG ---"; psfg'
alias vibash="\$EDITOR \$HOME/.bashrc"
alias vii3="\$EDITOR \$HOME/.config/i3/config"
alias vitmux="\$EDITOR \$HOME/.tmux.conf"
alias vialacritty="\$EDITOR \$HOME/.config/alacritty/alacritty.yml"
alias vimutt="cd \$HOME/.config/mutt && \$EDITOR muttrc"
alias vivim="cd \$HOME/.config/nvim && \$EDITOR init.lua"
alias ddgr="ddgr -n9"
alias bat="bat -n"
alias dpss='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}"'
alias yt='YTFZF_PLAYER=/usr/bin/mpv YTFZF_PLAYER_FORMAT="/usr/bin/mpv --ytdl-format=" ytfzf -f'

alias gcm='git commit'
alias gdf='git diff'
alias gdm='git diff master'
alias glm='git log master..'
alias gdo='git diff origin/$(git rev-parse --abbrev-ref HEAD)'
alias gds='git diff --staged'
alias gst='git status'
alias gbv='git branch -vv'
alias gpf='git push --force-with-lease'
alias gun='git add -A && git commit -m "Update notes"'

alias gad='git status | fpp -c "git add"'
alias grh='git status | fpp -c "git reset HEAD"'
alias gco='git status | fpp -c "git checkout"'
alias gadp='git status | fpp -c "git add -p"'
alias grs='git status | fpp -c "git restore"'

if [[ -f $HOME/.config/bash/private_aliases.sh ]]; then
    . $HOME/.config/bash/private_aliases.sh
fi
if [[ -f $HOME/.config/bash/private_env.sh ]]; then
    . $HOME/.config/bash/private_env.sh
fi

man() {
    env \
    LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
    LESS_TERMCAP_md="$(printf "\e[1;31m")" \
    LESS_TERMCAP_me="$(printf "\e[0m")" \
    LESS_TERMCAP_se="$(printf "\e[0m")" \
    LESS_TERMCAP_so="$(printf "\e[1;44;33m")" \
    LESS_TERMCAP_ue="$(printf "\e[0m")" \
    LESS_TERMCAP_us="$(printf "\e[1;32m")" \
    man "${@}"
}

zet() {
  nvim "+Zet $*"
}

pathadd() {
    case ":$PATH:" in
        *":$1:"*) return ;;
    esac
    if [ -d "$1" ]; then
        PATH="$1:$PATH"
    fi
}
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d $PYENV_ROOT ]]; then
    pathadd "$PYENV_ROOT/bin"
    pathadd "$PYENV_ROOT/shims"
    source "$PYENV_ROOT/completions/pyenv.bash"
fi
# goenv
export GOENV_ROOT="$HOME/.goenv"
if [[ -d $GOENV_ROOT ]]; then
    pathadd "$GOENV_ROOT/bin"
    pathadd "$GOENV_ROOT/shims"
    source "$GOENV_ROOT/completions/goenv.bash"
fi
# plenv
if [[ -d $HOME/.plenv ]]; then
    pathadd "$HOME/.plenv/bin"
    pathadd "$HOME/.plenv/shims"
fi
# nodenv
if [[ -d $HOME/.nodenv ]]; then
    pathadd "$HOME/.nodenv/bin"
    pathadd "$HOME/.nodenv/shims"
    source "$HOME/.nodenv/completions/nodenv.bash"
fi

unset -f pathadd

if command -v direnv > /dev/null; then
    eval "$(direnv hook bash)"
fi
