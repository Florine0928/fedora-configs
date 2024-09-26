#!/bin/bash

# Check if Waybar is running
if pgrep -x "waybar" > /dev/null
then
    pkill -x "waybar"
    echo "Waybar has been killed."
else
    echo "Waybar is not running."
fi

# Start Waybar
waybar &

# Check if swaybg is running
if pgrep -x "swaybg" > /dev/null
then
    pkill -x "swaybg"
    echo "swaybg has been killed."
else
    echo "swaybg is not running."
fi

# Start swaybg with specified wallpaper
swaybg -i ~/Wallpapers/hardahh.jpg &
