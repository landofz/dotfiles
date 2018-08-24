# if not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTCONTROL='erasedups:ignoreboth'
HISTIGNORE=?:??
shopt -s histappend
HISTSIZE=9999
HISTFILESIZE=9999

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
    [[ -r ~/.dircolors ]] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=always --classify -v --author --time-style=long-iso'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
fi

export EDITOR=vim
export VISUAL=vim
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
#if [[ -e /lib/terminfo/x/xterm-256color ]]; then
    #export TERM='xterm-256color'
#else
    #export TERM='xterm-color'
#fi
export WORKON_HOME=$HOME/virtualenv

[[ -s ~/lib/up/up.sh ]] && source ~/lib/up/up.sh
[[ -s /usr/local/bin/virtualenvwrapper.sh ]] && source /usr/local/bin/virtualenvwrapper.sh
[[ -s ~/.bash-powerline.sh ]] && source ~/.bash-powerline.sh
[[ -s ~/.gvm/scripts/gvm ]] && source ~/.gvm/scripts/gvm
[[ -s ~/.config/fzf/fzf.bash ]] && source ~/.config/fzf/fzf.bash

alias gnvim='NVIM_TUI_ENABLE_TRUE_COLOR= nvim-wrapper'
alias psvim='ps aux | grep vim'

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
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
