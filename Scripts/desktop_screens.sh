#!/bin/sh
xrandr --output HDMI-2 --mode 2560x1080 --rotate inverted --pos 440x0 --output DP-2 --mode 3440x1440 --rate 100 --primary --pos 0x1080 --output HDMI-1 --mode 1920x1080 --pos 3440x1080
i3-msg "workspace 2; move workspace to output HDMI-2"
i3-msg "workspace 3; move workspace to output HDMI-1"
i3-msg "workspace 1; move workspace to output DP-2"
