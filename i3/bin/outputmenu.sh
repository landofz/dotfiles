#!/bin/bash

res=$(ls $HOME/.screenlayout | cut -d. -f1 | rofi -dmenu -p "outputs" -dpi 1)

$HOME/.screenlayout/$res.sh

if [ -e "$HOME/Pictures/wall.jpg" ]; then
    xwallpaper --stretch "$HOME/Pictures/wall.jpg"
fi
