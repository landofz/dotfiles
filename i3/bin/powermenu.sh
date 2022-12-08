#!/bin/bash

res=$(echo -e "suspend\nlogout\nreboot\nshutdown\nhibernate\nsuspend-hibernate" | rofi -dmenu -p "power:" -dpi 1)

function logout() {
    # TODO: close all windows
    #for node_id in $(bspc query -N); do
        #bspc node $node_id -c
    #done
    #bspc quit
    i3-msg exit
}

case $res in
    halt|poweroff|shutdown)
        exec systemctl poweroff
        ;;
    suspend-hibernate)
        exec systemctl suspend-then-hibernate
        ;;
    hibernate)
        exec systemctl hibernate
        ;;
    logout)
        logout
        ;;
    restart|reboot)
        exec systemctl reboot
        ;;
    suspend)
        exec systemctl suspend
        ;;
    *)
esac
