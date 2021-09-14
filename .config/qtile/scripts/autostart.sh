#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

#start sxhkd to replace Qtile native key-bindings
run sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc &

#starting utility applications at boot time
#run variety &
#nitrogen --restore
sh .config/qtile/scripts/live_wallpaper.sh /mnt/MyBook/wallpapers/video/nobara_roses.mp4
run caffeine &
run nm-applet &
run redshift-gtk -l 46.4:9.35 &
run pamac-tray &
run xfce4-power-manager &
run volumeicon &
numlockx on &
#blueberry-tray &
#picom --config $HOME/.config/qtile/scripts/picom.conf &
picom --config $HOME/.config/qtile/scripts/picom-jonaburg.conf &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &

#starting user applications at boot time
run firefox &
run spotify &
run kdeconnect-indicator &
run telegram-desktop &
