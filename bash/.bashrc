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
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# enable color support of ls and also add handy aliases
if command -v dircolors > /dev/null; then
    [[ -r ~/.config/dircolors ]] && eval "$(dircolors -b ~/.config/dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=always --classify -v --author --time-style=long-iso'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='exa -lg'
alias la='exa -a'
alias lt='exa --tree'
alias l='ls -CF'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
fi

export EDITOR=nvim
export VISUAL=nvim
export BROWSER=qutebrowser
export LESS='--quit-if-one-screen --ignore-case --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
export PAGER=less
export WORKON_HOME=$HOME/virtualenv

[[ -s ~/lib/up/up.sh ]] && source ~/lib/up/up.sh
[[ -s ~/.local/bin/virtualenvwrapper.sh ]] && source ~/.local/bin/virtualenvwrapper.sh
#[[ -s ~/.bash-powerline.sh ]] && source ~/.bash-powerline.sh
eval "$(starship init bash)"
[[ -s ~/.config/fzf/fzf.bash ]] && source ~/.config/fzf/fzf.bash
if [[ -z "$GVM_ROOT" ]]; then
    [[ -s ~/.gvm/scripts/gvm ]] && source ~/.gvm/scripts/gvm
else
    [[ -s ~/.gvm/scripts/env/gvm ]] && source "$HOME/.gvm/scripts/env/gvm"
fi
[[ -s ~/lib/goto/goto.sh ]] && source ~/lib/goto/goto.sh

alias gnvim='NVIM_TUI_ENABLE_TRUE_COLOR= nvim-wrapper'
alias psvim='ps aux | grep -v grep | grep vim'
alias psbg='ps aux | grep "pts/[0-9]\+ \+T" | grep -v grep'
alias psfg='ps aux | grep pts | grep -v "\-bash" | grep "\+" | grep -v tmux | grep -v grep | grep -v "ps aux"'
alias psall='echo "--- BG ---"; psbg; echo "--- FG ---"; psfg'
alias vibash="nvim $HOME/.bashrc"
alias vii3="nvim $HOME/.config/i3/config"
alias vitmux="nvim $HOME/.tmux.conf"
alias vialacritty="nvim $HOME/.config/alacritty/alacritty.yml"
alias ddgr="ddgr -n9"
alias bat="bat -n"
alias dpss='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}"'

alias gcm='git commit'
alias gdf='git diff'
alias gdm='git diff master'
alias glm='git log master..'
alias gds='git diff --staged'
alias gst='git status'
alias gbv='git branch -vv'
alias gpf='git push --force-with-lease'
alias gun='git add -A && git commit -m "Update notes"'

alias gad='git status | fpp -c "git add"'
alias grh='git status | fpp -c "git reset HEAD"'
alias gco='git status | fpp -c "git checkout"'
alias gadp='git status | fpp -c "git add -p"'

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
