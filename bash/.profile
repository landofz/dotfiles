# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1${PATH:+":$PATH"}"
    fi
}

if command -v keychain > /dev/null; then
    eval "$(keychain --eval --agents ssh)"
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

pathadd "$HOME/.local/bin"
pathadd "$HOME/bin"
pathadd "$HOME/.cargo/bin"

# To avoid potential situation where tdm(1) crashes on every TTY, here we
# default to execute tdm(1) on tty1 only, and leave other TTYs untouched.
if [[ "$(tty)" == '/dev/tty1' ]]; then
    unicode_start
    if command -v tdm > /dev/null; then
        tdm
        logout
    fi
fi
