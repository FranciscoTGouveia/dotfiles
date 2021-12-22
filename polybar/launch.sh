#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Launch bar
echo "---"
polybar mybar
echo "Bar launched..."
