# set custom keybindings
bind -k nul accept-autosuggestion
bind \b backward-kill-word
bind \e\[3\;5~ kill-word

# basic settings (export)
set fish_greeting
set TERM "alacritty"
set EDITOR "nvim"
set VISUAL "nvim"

# set autocomplete colors
set fish_color_normal normal
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command green
set fish_color_error brcyan
set fish_color_param yellow

# SET EITHER DEFAULT EMACS MODE OR VI MODE
function fish_user_key_bindings
  fish_default_key_bindings
  # fish_vi_key_bindings
end

# get aliases to work with sudo

# bash like ! and !!
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end
bind ! __history_previous_command
bind '$' __history_previous_command_arguments

if test "$fish_key_bindings" = 'fish_vi_key_bindings'
    bind --mode insert ! __history_previous_command
    bind --mode insert '$' __history_previous_command_arguments
end

function _plugin-bang-bang_uninstall --on-event plugin-bang-bang_uninstall
    bind --erase --all !
    bind --erase --all '$'
    functions --erase _plugin-bang-bang_uninstall
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/giuseppe/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# Run fetch tool at startup in interactive session
if status is-interactive
    # commands for interactive sessions
    # neofetch
    /home/giuseppe/.scripts/fetch.sh
end

# autojump
if test -f /home/giuseppe/.autojump/share/autojump/autojump.fish; . /home/giuseppe/.autojump/share/autojump/autojump.fish; end

# import aliases
source "$HOME/.aliases"

# init starship prompt
starship init fish | source

# add .local/bin to path
if [ -d "$HOME/.local/bin" ]
    set PATH "$HOME/.local/bin:$PATH"
end

# GNOME-KEYRING
#if test -n "$DESKTOP_SESSION"
#    set -x (gnome-keyring-daemon --start | string split "=")
#end

#set -x DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
#
#pgrep dbus-daemon > /dev/null
#
#if test $status -eq 1
#  dbus-launch --sh-syntax | read --line bus_address ignored bus_pid bus_windowid
#
#  set -Ux DBUS_SESSION_BUS_ADDRESS (string match -r "'(.*)'" $bus_address)[2]
#  set -Ux DBUS_SESSION_BUS_ID (string match -r "=(.*);" $bus_pid)[2]
#  set -Ux DBUS_SESSION_BUS_WINDOWID (string match -r "=(.*);" $bus_windowid)[2]
#end
#
## pgrep limited to 15 chars, so truncate `daemon`
#pgrep gnome-keyring-d > /dev/null
#
#if test $status -eq 1
#  gnome-keyring-daemon | read --line gnome_keyring_control ssh_auth_sock
#
#  set -Ux GNOME_KEYRING_CONTROL (string split -m 1 = $gnome_keyring_control)[2]
#  set -Ux SSH_AUTH_SOCK (string split -m 1 = $ssh_auth_sock)[2]
#end

# ssh
eval "$(ssh-agent -c)" > /dev/null
