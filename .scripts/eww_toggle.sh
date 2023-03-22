#!/bin/bash

if [ "$1" = "" ]; then
    echo "Argument needed"
    exit
fi

toggle=$HOME/.config/eww/locks/$1.lock

if [ "$2" = "off" ]; then
    rm $toggle
    eww close $1
    eww update $1-window-active=false
    exit
fi

if [ ! -e $toggle ] || [ "${2}" = "on" ]; then
    touch $toggle
    eww open $1
    eww update $1-window-active=true
else
    rm $toggle
    eww close $1
    eww update $1-window-active=false
fi
