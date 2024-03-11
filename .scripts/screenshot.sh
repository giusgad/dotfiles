if ! [[ $(ps aux | grep grimshot | grep -v grep) ]]; then
    grimshot copy area
fi
