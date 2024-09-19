# bash
# Increase volume but do not exceed 100%
x=$(pactl get-sink-volume @DEFAULT_SINK@ | grep '[0-9]*%' -o  );y=$(echo $x| cut -d ' ' -f1);z=${y::-1};if [[ $z -le 95 ]];then pactl set-sink-volume @DEFAULT_SINK@ +5%;fi;
