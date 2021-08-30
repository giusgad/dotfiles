# basic settings (export)
set fish_greeting
set TERM "alacritty"
set EDITOR "vim"
set VISUAL "vim"

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


# run neofetch at startup
if status is-interactive
    # commands for interactive sessions
    neofetch
end

# import aliases
source "$HOME/.aliases"

# init starship prompt
starship init fish | source
