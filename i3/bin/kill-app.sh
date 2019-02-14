#!/bin/bash
set -euo pipefail

res=$(i3-msg -t get_tree | jq -r '.nodes[].nodes[] | select(.name | contains("content")) | .nodes[] | select(.name | contains("__") | not) | .nodes[].nodes[].window_properties.instance' | rofi -dmenu -p "kill")

pkill "$res"
