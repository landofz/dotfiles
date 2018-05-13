#!/bin/bash

xsetroot -cursor_name left_ptr &
xset s 300 5
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock &

function wm() {
    [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
    exec $1
}

[[ -z $1 ]] && wm i3

wm $1
