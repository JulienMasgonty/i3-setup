#!/bin/bash

# Terminate already running bar instances
killall -q polybar

echo "---" | tee -a /tmp/polybar.log
polybar main 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched"
