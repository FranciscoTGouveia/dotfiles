#!/usr/bin/env bash

# initializing wallpaper daemon
swww init &
# setting wallpaper
swww img "/home/francisco/.config/hypr/boat_in_sea.png" &

# network manager applet
# nm-applet --indicator &

# status bar
waybar &
