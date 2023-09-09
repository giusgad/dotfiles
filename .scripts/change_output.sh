#!/bin/bash
CARD1="alsa_output.usb-Kingston_HyperX_Virtual_Surround_Sound_00000000-00"
CARD2="alsa_output.pci-0000_0a_00.3"

CURRENT_SINK=$(pacmd stat | awk -F": " '/^Default sink name: /{print $2}' | awk 'BEGIN{FS=OFS="."} NF--' | sed 's/alsa_output/alsa_output/g')


function setCard() {

  if [ "$CURRENT_SINK" == "$1" ]
   then
     echo "Already using this Sink"
     exit 1
  fi

  NEW_SINK=$(pacmd list-sinks | awk '/index:/ {print $1 $2 $3} /name:/ {print $0};' | grep -m1 -B1 $1 | grep index | awk '{print $1}' | cut -d ":" -f2)
  pacmd set-default-sink $NEW_SINK
  INPUT=$(pacmd list-sink-inputs | grep index | awk '{print $2}')

  for i in $INPUT; do
    pacmd move-sink-input $i $NEW_SINK
  done
  echo "Moving input: $INPUT to sink: $NEW_SINK";
  echo "Setting default sink to: $NEW_SINK";

  if [ "$NEW_SINK" == "1" ]
    then
      NOTIF="Headphones"
      NOTIFICON="audio-headphones"
    else
      NOTIF="Speakers"
      NOTIFICON="audio-speakers"
    fi
  notify-send --urgency=low "Output switched to $NOTIF" --icon=$NOTIFICON
}

function toggleSinks() {
  if [ "$CURRENT_SINK" == "$CARD1" ]
    then
      setCard $CARD2
    else
      setCard $CARD1
    fi
}

# check args length
if [ $# -eq 0 ]
  then
    echo "Toggling output devices (Speakers/Headset)"
    toggleSinks
fi


# arg options
while test $# -gt 0; do
    case "$1" in

                -h|--help)
                        showHelp
                        exit 1
                        ;;

                -g|--gaming)
                        setCard $CARD2
                        exit 1
                        ;;

                -s|--speakers)
                        setCard $CARD1
                        exit 1
                        ;;

                -t|--toggle)
                        toggleSinks
                        echo "Toggling output devices (Speakers/Headset)"
                        exit 1
                        ;;
                 *)
                        showHelp
                        exit 1
                        ;;
    esac
done
