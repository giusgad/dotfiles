#!/bin/bash

function randomInDir() {
    if [[ $# -lt 1 ]] || [[ ! -d $1   ]]; then
        echo "Usage:
        $0 <dir containing images>"
        exit 1
    fi

    INTERVAL=600

    while true; do
        find "$1" -type f \
            | while read -r img; do
                echo "$((RANDOM % 1000)):$img"
            done \
            | sort -n | cut -d':' -f2- \
            | while read -r img; do
                swww img "$img" -t random
                sleep $INTERVAL
            done
    done
}

swww-daemon --format xrgb > /dev/null

while swww init&>/dev/null; do
    sleep 1
done

randomInDir $1
