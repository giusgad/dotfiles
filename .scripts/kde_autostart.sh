#!/bin/sh

sudo rmmod pcspkr
caffeine &
dunstctl set-paused true
$HOME/.scripts/tmux-sessions.sh

export MOZ_GTK_TITLEBAR_DECORATION=system
