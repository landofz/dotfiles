# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

pathadd() {
    case ":$PATH:" in
        *":$1:"*) return ;;
    esac
    if [ -d "$1" ]; then
        PATH="$1:$PATH"
    fi
}

if command -v keychain > /dev/null; then
    if [ -z "$SSH_AUTH_SOCK" ]; then
        eval "$(keychain --eval --agents ssh)"
    fi
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

pathadd "$HOME/.local/bin"
pathadd "$HOME/bin"
pathadd "$HOME/.cargo/bin"

if [ "x$(tty)" = 'x/dev/tty1' ]; then
    unicode_start
    if command -v startx > /dev/null; then
        startx
        logout
    fi
fi
