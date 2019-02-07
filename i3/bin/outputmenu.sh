#!/bin/bash

res=$(ls $HOME/.screenlayout | cut -d. -f1 | rofi -dmenu -p "outputs")

$HOME/.screenlayout/$res.sh
