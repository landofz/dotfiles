#!/bin/bash
set -euo pipefail

res=$(i3-msg -t get_tree | jq -r '.nodes[].nodes[] | select(.name | contains("content")) | .nodes[] | select(.name | contains("__") | not) | .nodes[].nodes[].window_properties | "\(.instance) - \(.class)"' | rofi -dmenu -i -p "kill")

if [ x"${res/ - */}"x = xNavigatorx ]; then
    pkill "${res/* - /}"
else
    pkill "${res/ - */}"
fi
