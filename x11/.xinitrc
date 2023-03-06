#!/bin/bash

# update environment used for D-Bus session services
dbus-update-activation-environment --systemd DISPLAY
systemctl --user import-environment DISPLAY

# /usr/bin/gnome-keyring-daemon --start --components=secrets
lxqt-policykit-agent &
setxkbmap -layout hr,us -variant us, -option ctrl:nocaps
xsetroot -cursor_name left_ptr &
xset s 300 5
if [ -f ~/.Xresources ]; then
    xrdb -merge ~/.Xresources
fi
XSECURELOCK_BLANK_TIMEOUT=10 xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock &
if [ -e "$HOME/Pictures/wall.jpg" ]; then
    xwallpaper --stretch "$HOME/Pictures/wall.jpg"
fi
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1

picom &
dunst &

if [ -z "$1" ]; then
    exec i3
fi
exec "$@"
