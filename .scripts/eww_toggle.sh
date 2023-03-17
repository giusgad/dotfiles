#!/bin/bash

if [ "$1" = "" ]; then
    echo "Argument needed"
    exit
fi

toggle=$HOME/.config/eww/locks/$1.lock

if [ ! -e $toggle ] || [ "${2}" = "first" ]; then
    touch $toggle
    eww open $1 && eww reload
else
    rm $toggle
    eww close $1
fi
