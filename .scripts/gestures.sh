active=$(hyprctl activewindow -j | jq '.class')

swipe_down_3() {

}

swipe_left_3() {

}

swipe_right_3() {

}

swipe_up_3() {

}

[ "$1" = "swipe-up-3" ] && swipe_up_3 && exit
[ "$1" = "swipe-left-3" ] && swipe_left_3 && exit
[ "$1" = "swipe-right-3" ] && swipe_right_3 && exit
[ "$1" = "swipe-down-3" ] && swipe_down_3 && exit
exit
