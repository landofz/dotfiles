# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# Enforce correct locales from the beginning:
# LC_ALL is unset since it overwrites everything
# LC_MESSAGES=C.UTF-8 never translates program output
# LC_TIME=en_GB.UTF-8 leads to yyyy-mm-dd hh:mm date/time output
unset LC_ALL
export LANG="en_US.UTF-8"
export LC_ADDRESS="hr_HR.UTF-8"
export LC_COLLATE="hr_HR.UTF-8"
export LC_CTYPE="C.UTF-8"
export LC_IDENTIFICATION="hr_HR.UTF-8"
export LC_MEASUREMENT="hr_HR.UTF-8"
export LC_MESSAGES="C.UTF-8"
export LC_MONETARY="hr_HR.UTF-8"
export LC_NAME="hr_HR.UTF-8"
export LC_NUMERIC="hr_HR.UTF-8"
export LC_PAPER="hr_HR.UTF-8"
export LC_TELEPHONE="hr_HR.UTF-8"
export LC_TIME="en_GB.UTF-8"

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

pathadd "$HOME/.local/bin"
pathadd "$HOME/bin"
pathadd "$HOME/.cargo/bin"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

if [ "$(tty)" = "/dev/tty1" ] && [ -z "${DISPLAY}" ]; then
    unicode_start
    if command -v startx > /dev/null; then
        startx
        logout
    fi
fi
