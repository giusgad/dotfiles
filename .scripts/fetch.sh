# run neofetch or pfetch based on the width of the terminal
# the width is calculated with the output of "tput cols"

if [ $(tput cols) -le 100 ] || [ $(tput lines) -le 30 ]; then
    pfetch
else
    neofetch
fi
