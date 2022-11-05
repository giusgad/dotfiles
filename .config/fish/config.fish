### KEYBINDINGS
# emacs mode
bind -k nul accept-autosuggestion
bind \b backward-kill-word
bind \e\[3\;5~ kill-word

# vi mode keybindings
bind -k nul --mode insert accept-autosuggestion
bind --mode insert \b backward-kill-word
bind --mode insert \cp up-or-search


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

### EXPORTS
# basic settings (export)
set fish_greeting
set TERM "kitty"
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
  # fish_default_key_bindings
  fish_vi_key_bindings
end

### CONDA
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/giuseppe/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# Run fetch tool at startup in interactive session
if status is-interactive
    # neofetch
    /home/giuseppe/.scripts/fetch.sh
end

### AUTOJUMP
if test -f /home/giuseppe/.autojump/share/autojump/autojump.fish; . /home/giuseppe/.autojump/share/autojump/autojump.fish; end

### IMPORT ALIASES
source "$HOME/.aliases"

### STARSHIP PROMPT
starship init fish | source

### PATH
# add .local/bin
if [ -d "$HOME/.local/bin" ]
    set PATH "$HOME/.local/bin:$PATH"
end

### SSH
if not pgrep --full ssh-agent | string collect > /dev/null
  eval (ssh-agent -c)
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
  set -Ux SSH_AGENT_PID $SSH_AGENT_PID
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
end

### OTHER
# fix for E79: Cannot load wildcards
set -x SHELL /bin/bash
