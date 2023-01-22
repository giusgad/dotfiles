#!/bin/bash
# run a fetch tool randomly chosen between sets based on terminal size

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

# medium fetches
if [ -f "/bin/nitch" ] ; then
    arr+=("nitch")
fi
if [ -f "/bin/rxfetch" ] ; then
    arr+=("rxfetch")
fi
arr+=("small")

if [ $(tput cols) -le 100 ]; then
    if [ $(tput lines) -le 30 ]; then
        small
    else
        size=${#arr[@]}
        index=$(($RANDOM % $size))
        ${arr[$index]}
    fi
else
    # big fetch
    if [ -f /bin/fastfetch ] ; then
        arr+=("fastfetch")
    elif [ -f /bin/neofetch ] ; then
        arr+=("neofetch")
    fi
    size=${#arr[@]}
    index=$(($RANDOM % $size))
    ${arr[$index]}
fi
