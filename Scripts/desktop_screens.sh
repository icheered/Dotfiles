#!/bin/sh
xrandr --output DP-1 --primary --mode 3440x1440 --rate 144 --pos 0x0 --rotate normal --output DP-2 --off --output HDMI-1 --mode 1920x1080 --pos 3440x180 --rotate normal --output HDMI-2 --mode 2560x1080 --pos 440x1440 --rotate inverted
i3-msg "workspace 1; move workspace to output DP-1"
i3-msg "workspace 2; move workspace to output HDMI-2"
i3-msg "workspace 3; move workspace to output HDMI-1"
