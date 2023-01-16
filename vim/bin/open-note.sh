#!/bin/sh
set -e

cd "$HOME/storage/Notebook"

if [ -n "$WAYLAND_DISPLAY" ]; then
  file=$(fd --type file | bemenu --fn 'Hack 11' -p "notebook:" -i -l 20)
else
  file=$(fd --type file | rofi -dmenu -no-custom -i -p "notebook" -dpi 1)
fi

[ -n "$file" ] || exit

exec alacritty --working-directory "$HOME/storage/Notebook" -e nvim "$file"
