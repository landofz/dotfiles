#!/bin/bash

dbus-update-activation-environment --systemd DISPLAY
systemctl --user import-environment DISPLAY
setxkbmap -layout hr,us -variant us, -option ctrl:nocaps
xsetroot -cursor_name left_ptr &
xset s 300 5
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
XSECURELOCK_BLANK_TIMEOUT=10 xss-lock -n /usr/local/libexec/xsecurelock/dimmer -l -- xsecurelock &

[[ -z $1 ]] && exec ssh-agent tdm --xstart
exec $@
