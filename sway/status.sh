audio_volume=$(pactl list sinks | grep "^[[:space:]]Volume:" | awk 'FNR ==3 {print $5}')
audio_is_muted=$(pamixer --sink `pactl list sinks short | grep RUNNING | awk '{print $1}'` --get-mute)

network=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')
interface_easyname=$(doas dmesg | grep $network | grep renamed | awk 'NF>1{print $NF}')
ping=$(ping -c 1 www.google.com.br | tail -1| awk '{print $4}' | cut -d '/' -f 2 | cut -d '.' -f 1)

date_formatted=$(date '+%d/%m/%Y %X')

if ! [ $network ]
then
   network_active="E: down"
else
   network_active="E:"
fi

if [ $audio_is_muted = "true" ]
then
    audio_active='VOL:'
else
    audio_active='VOL:'
fi


echo -e "<span foreground='#00ff00'>$network_active $interface_easyname</span> ($ping ms) | $audio_active $audio_volume | $date_formatted"

#echo $audio_volume "|" $date_formatted
