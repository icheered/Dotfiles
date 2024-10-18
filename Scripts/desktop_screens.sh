# bash
xrandr --output HDMI-2 --mode 2560x1080 --pos 440x2560 --rotate normal --output DP-2 --mode 3440x1440 --rate 120 --primary --pos 0x1080 --output HDMI-1 --mode 1920x1080 --pos 3440x2000
i3-msg "workspace 2; move workspace to output HDMI-2"
i3-msg "workspace 3; move workspace to output HDMI-1"
i3-msg "workspace 1; move workspace to output DP-2"
