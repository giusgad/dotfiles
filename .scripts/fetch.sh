#!/bin/bash
# run neofetch or pfetch based on the width of the terminal
# the width is calculated with the output of "tput cols"

function small {
    if [ -f "/bin/pfetch" ] ; then
        array+=("pfetch")
    fi
    if [ -f "/bin/sfetch" ] ; then
        array+=("sfetch")
    fi
    if [ -f "/bin/nerdfetch" ] ; then
        array+=("nerdfetch")
    fi
    size=${#array[@]}
    index=$(($RANDOM % $size))
    exec ${array[$index]}
}

if [ $(tput cols) -le 100 ]; then
    if [ $(tput lines) -le 30 ]; then
        small
    else
        if [ -f "/bin/nitch" ] ; then
            arr+=("nitch")
        fi
        if [ -f "/bin/rxfetch" ] ; then
            arr+=("rxfetch")
        fi
        arr+=("small")
        size=${#arr[@]}
        index=$(($RANDOM % $size))
        ${arr[$index]}
    fi
else
    arr[0]=small
    if [ -f /bin/fastfetch ] ; then
        arr[1]=fastfetch
        size=${#arr[@]}
        index=$(($RANDOM % $size))
        ${arr[$index]}
    elif [ -f /bin/neofetch ] ; then
        arr[1]=neofetch
        size=${#arr[@]}
        index=$(($RANDOM % $size))
        ${arr[$index]}
    else
        small
    fi
fi
