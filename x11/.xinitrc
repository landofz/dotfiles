#!/bin/bash

dbus-update-activation-environment --systemd DISPLAY
systemctl --user import-environment DISPLAY
setxkbmap -layout hr,us -variant us, -option ctrl:nocaps
xsetroot -cursor_name left_ptr &
xset s 300 5
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock &

[[ -z $1 ]] && exec ssh-agent tdm --xstart
exec $@
