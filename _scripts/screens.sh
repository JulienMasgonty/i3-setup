#!/bin/bash

xrandr \
	--output DP-5 --mode 1920x1080 --rate 30 --right-of HDMI-0 \
	--output HDMI-0 --primary
