#!/bin/bash

# Terminate already running bar instances
killall -q polybar

echo "---" | tee -a /tmp/polybar.log
if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d " " -f1); do
		MONITOR=$m polybar main 2>&1 | tee -a /tmp/polybar.log & disown
	done
else
	polybar main 2>&1 | tee -a /tmp/polybar.log & disown
fi


echo "Polybar launched"
