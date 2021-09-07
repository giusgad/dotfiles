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
nitrogen --restore
run caffeine &
run nm-applet &
run redshift -l 46.4:9.35 &
run pamac-tray &
run xfce4-power-manager &
run volumeicon &
numlockx on &
#blueberry-tray &
picom --config $HOME/.config/qtile/scripts/picom.conf &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &

#starting user applications at boot time
run firefox &
run spotify &
run kdeconnect-indicator &
run telegram-desktop &
