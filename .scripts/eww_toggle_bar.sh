#!/bin/bash

toggle=$HOME/.config/eww/bar.lock

if [ ! -e $toggle ] || [ "${1}" = "first" ]; then
    touch $toggle
    eww open bar
else
    rm $toggle
    eww close bar
fi
