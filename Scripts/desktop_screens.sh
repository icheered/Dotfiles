# bash
xrandr --output DP-1 --mode 3440x1440 --rate 120 --primary \
  --output HDMI-2 --mode 2560x1080 --pos 880x1440 \
  --output HDMI-1 --mode 1920x1080 --pos 3440x800
i3-msg "workspace 1; move workspace to output DP-2"
i3-msg "workspace 2; move workspace to output HDMI-2"
i3-msg "workspace 3; move workspace to output HDMI-1"