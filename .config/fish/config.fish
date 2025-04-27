### EXPORTS
# basic settings (export)
set fish_greeting
# set TERM "kitty"
set -gx EDITOR "nvim"
set -gx VISUAL "nvim"

### KEYBINDINGS
# emacs mode
bind ctrl-space accept-autosuggestion
bind \b backward-kill-word
bind \e\[3\;5~ kill-word

# vi mode keybindings
bind ctrl-space --mode insert accept-autosuggestion
bind --mode insert \b backward-kill-word
bind --mode insert \cp up-or-search
bind --mode insert \cn down-or-search 
bind --mode insert \c] 'clear; commandline -f repaint'
bind --mode default \c] 'clear; commandline -f repaint'

# SET EITHER DEFAULT EMACS MODE OR VI MODE
function fish_user_key_bindings
  # fish_default_key_bindings
  fish_vi_key_bindings
end

# set autocomplete colors
set fish_color_normal normal
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command green
set fish_color_error brcyan
set fish_color_param yellow

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

bind --mode insert ! __history_previous_command
bind --mode insert '$' __history_previous_command_arguments

# set man pages colors - see https://man.archlinux.org/man/less.1#D
set -xU MANPAGER 'less -R --use-color -Dd+y -Du+b'

### ALIASES
source "$HOME/.aliases"
function mvk
    mkdir $argv[1]; mv -t $argv
end
function zn
    z $argv && nvim
end

### STARSHIP PROMPT
starship init fish | source

### PATH
# add .local/bin
if [ -d "$HOME/.local/bin" ]
    set PATH "$HOME/.local/bin:$PATH"
end
if [ -d "$HOME/.cargo/bin" ]
    set PATH "$HOME/.cargo/bin:$PATH"
end
set PATH "$GOPATH/bin:$PATH"

### SSH
if not pgrep --full ssh-agent | string collect > /dev/null
  eval (ssh-agent -c)
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
  set -Ux SSH_AGENT_PID $SSH_AGENT_PID
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
end

### ANDROID
set -Ux ANDROID_SDK_ROOT /opt/android-sdk
set PATH "$PATH:$ANDROID_SDK_ROOT/emulator/"
set PATH "$PATH:$ANDROID_SDK_ROOT/platform-tools/"
set PATH "$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/"
set PATH "$PATH:$ANDROID_SDK_ROOT/tools"
set -Ux JAVA_HOME /usr/lib/jvm/java-17-openjdk
set -Ux JAVA_OPTS ""

## bob (nvim version manager)
# set PATH "$PATH:$HOME/.local/share/bob/nvim-bin"

### OTHER
# fix for E79: Cannot load wildcards
set -x SHELL /bin/bash

## zoxide (autojump)
zoxide init fish | source
