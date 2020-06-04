#!/bin/bash
set -eu

sink=$(pactl list sinks short | grep "alsa_output.*analog-stereo" | cut -f1)
mic=$(pactl list sources short | grep "alsa_input.*analog-stereo" | cut -f1)
icon_on="\uf028"
icon_off="\uf026"

function level() {
    pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $sink + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,'
}

function muted() {
    pactl list sinks | grep '^[[:space:]]Mute:' | head -n $(( $sink + 1 )) | tail -n 1 | sed -e 's#.* \([y,n][a-z]*\).*#\1#'
}

is_mic=0
case $1 in
    -|down) pactl set-sink-volume $sink -5% >/dev/null;;
    +|up) pactl set-sink-volume $sink +5% >/dev/null;;
    !|toggle) pactl set-sink-mute $sink toggle >/dev/null;;
    %|mictoggle) pactl set-source-mute $mic toggle >/dev/null && is_mic=1;;
    *) pactl set-sink-volume $sink $1% >/dev/null;;
esac

if [[ $(muted) == "yes" ]]; then
    text="$icon_off x"
else
    text="$icon_on $(level)"
fi

if [[ "$is_mic" == "0" ]]; then
    notify-send "Volume" "$(echo -e $text)" -t 500 -u normal
fi

pkill -SIGRTMIN+10 i3blocks
