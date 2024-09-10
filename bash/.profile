# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 027

# Enforce correct locales from the beginning (man 7 locale):
# LC_ALL is unset since it overwrites everything
# LC_MESSAGES=C.UTF-8 never translates program output
# LC_TIME=en_GB.UTF-8 leads to yyyy-mm-dd hh:mm date/time output
unset LC_ALL
export LANG="hr_HR.UTF-8"
export LC_CTYPE="C.UTF-8" # character classification rules (alpha, digit, ...) and text encoding
export LC_MESSAGES="C.UTF-8"
export LC_TIME="en_GB.UTF-8"
# use machine's default time zone (man timezone)
unset TZ

pathadd() {
    case ":$PATH:" in
        *":$1:"*) return ;;
    esac
    if [ -d "$1" ]; then
        PATH="$1:$PATH"
    fi
}

if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then . "$HOME/.nix-profile/etc/profile.d/nix.sh"; fi # added by Nix installer
# mostly for shell completions
export XDG_DATA_DIRS="$HOME/.nix-profile/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"

pathadd "$HOME/.local/bin"
pathadd "$HOME/bin"
pathadd "$HOME/.cargo/bin"

unset -f pathadd

# if running bash
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# locales workaround because glibc 2.27 introduced breaking change in locales
# binary data format, see
# https://sourceware.org/glibc/wiki/Release/2.27#Statically_compiled_applications_using_locales
# for more info
#export LOCALE_ARCHIVE_2_27="$(nix-build --no-out-link "<nixpkgs>" -A glibcLocales)/lib/locale/locale-archive"
LOCALE_ARCHIVE_2_27="$(readlink ~/.nix-profile/lib/locale)/locale-archive"
export LOCALE_ARCHIVE_2_27
export LOCALE_ARCHIVE="/usr/lib/locale"

if [ "$(tty)" = "/dev/tty1" ] && [ -z "${DISPLAY}" ]; then
    unicode_start
    if command -v startx > /dev/null; then
        startx
        logout
    fi
fi
