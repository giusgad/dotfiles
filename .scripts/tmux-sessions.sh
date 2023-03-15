#!/bin/bash

### NVIM
session="nvim"
tmux new-session -d -s $session -c $HOME/.config/nvim/lua/
window=1
tmux rename-window -t $session:$window 'config'

window=2
tmux new-window -d -t $session:$window -n 'dev' -c "/mnt/shared/coding/lua/plugins/pets.nvim"

### UNI
session="uni"
tmux new-session -d -s $session -c /mnt/shared/coding/uni/assembly/
window=1
tmux rename-window -t $session:$window 'archi'
# window=2
# tmux new-window -d -t $session:$window -n 'lab' -c /mnt/shared/coding/uni/lab/
