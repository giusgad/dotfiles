#!/bin/bash
# run neofetch or pfetch based on the width of the terminal
# the width is calculated with the output of "tput cols"

function small {
    if [ -f "/bin/pfetch" ] ; then
        array[0]=pfetch
    fi
    if [ -f "/bin/sfetch" ] ; then
        array[1]=sfetch
    fi
    size=${#array[@]}
    index=$(($RANDOM % $size))
    exec ${array[$index]}
}

if [ $(tput cols) -le 100 ] || [ $(tput lines) -le 30 ]; then
    small
else
    if [ -f /bin/fastfetch ] ; then
        fastfetch
    elif [ -f /bin/neofetch ] ; then
        neofetch
    else
        small
    fi
fi
