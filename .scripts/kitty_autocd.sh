windowclass=$(hyprctl activewindow | grep class | awk '{print $2}')
if [ "$windowclass" != kitty ]; then
    echo $HOME
    exit
fi
kitty_pid=$(hyprctl activewindow | grep pid | awk '{print $2}')
fish_pid=$(ps --ppid "$kitty_pid" -o pid=)
fish_pid=$(echo $fish_pid | awk '{print $2}')
dir=$(pwdx $fish_pid | awk '{print $2}')
if [ "$dir" = "" ]; then
    dir=$HOME
fi
echo $dir
