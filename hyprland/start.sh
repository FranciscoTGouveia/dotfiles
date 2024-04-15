#!/usr/bin/env bash

# initializing wallpaper daemon
swww init &
# setting wallpaper

# network manager applet
nm-applet --indicator &

# status bar
waybar &
