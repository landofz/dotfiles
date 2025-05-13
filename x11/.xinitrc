#!/bin/sh

# update environment used for D-Bus session services
dbus-update-activation-environment --systemd DISPLAY
systemctl --user import-environment DISPLAY
# dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY
# systemctl --user import-environment DBUS_SESSION_BUS_ADDRESS XAUTHORITY DISPLAY XDG_SESSION_ID

# merge in defaults and keymaps
# sysresources=/etc/X11/xinit/.Xresources
# sysmodmap=/etc/X11/xinit/.Xmodmap
# if [ -f $sysresources ]; then
#     xrdb -merge $sysresources
# fi
# if [ -f $sysmodmap ]; then
#     xmodmap $sysmodmap
# fi

# /usr/bin/gnome-keyring-daemon --start --components=secrets
lxqt-policykit-agent &
setxkbmap -layout hr,us -variant us, -option ctrl:nocaps
xsetroot -cursor_name left_ptr &
xset s 300 5
xset dpms 600 600 600
if [ -f ~/.Xresources ]; then
    xrdb -merge ~/.Xresources
fi
XSECURELOCK_BLANK_TIMEOUT=10 xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock &
if [ -e "$HOME/Pictures/wall.jpg" ]; then
    xwallpaper --stretch "$HOME/Pictures/wall.jpg"
fi
# enable touchpad tap to click
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1

# picom &
dunst &
unclutter &

if [ -z "$1" ]; then
    exec i3
fi
exec "$@"
