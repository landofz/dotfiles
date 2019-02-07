#!/bin/bash

i=10

level() {
    #xbacklight | awk '{print int(($1 + 2.5) / 5) * 5}'
    xbacklight -get
}

case $1 in
	-|down) xbacklight -steps 1 -time 0 -dec ${i} >/dev/null;;
	+|up) xbacklight -steps 1 -time 0 -inc ${i} >/dev/null;;
	*) xbacklight -steps 1 -time 0 -set $1 >/dev/null;;
esac

notify-send "Brightness" "$(echo -e '\uf185') $(level)" -t 500 -u normal
