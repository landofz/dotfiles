#!/bin/bash

xsetroot -cursor_name left_ptr &

function wm() {
    [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
    exec $1
}

[[ -z $1 ]] && wm i3

wm $1
