#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit

echo "---" | tee -a /tmp/polybar-top.log

# Launch
polybar top 2>&1 | tee -a /tmp/polybar-top.log & disown
polybar bottom 2>&1 | tee -a /tmp/polybar-bottom.log & disown

echo "Bars launched..."
