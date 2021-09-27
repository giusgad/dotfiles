#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

#get animated wallpaper
wallpaper=$(cat $HOME/.config/qtile/scripts/wallpaper_path)

#start sxhkd to replace Qtile native key-bindings
run sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc &

#starting utility applications at boot time
nitrogen --restore
sh .config/qtile/scripts/live_wallpaper.sh $wallpaper
run caffeine &
run nm-applet &
run redshift-gtk -l 46.4:9.35 &
run xfce4-power-manager &
# run volumeicon &
numlockx on &
picom --config $HOME/.config/qtile/scripts/picom-jonaburg.conf &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#/usr/lib/xfce4/notifyd/xfce4-notifyd &
/usr/bin/dunst &

#starting user applications at boot time
run kdeconnect-indicator &
run $HOME/.joplin/Joplin.AppImage &
