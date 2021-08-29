set fish_greeting

if status is-interactive
    # commands for interactive sessions
    neofetch
end

source "$HOME/.aliases"

starship init fish | source
