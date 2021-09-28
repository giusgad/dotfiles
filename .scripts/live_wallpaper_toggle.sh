#!/bin/bash
if pgrep -x "xwinwrap" > /dev/null
then
	killall xwinwrap mpv
else
	wallpaper=$(cat $HOME/.config/qtile/scripts/wallpaper_path)
	source $HOME/.scripts/live_wallpaper.sh $wallpaper
fi
