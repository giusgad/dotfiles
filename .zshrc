### PLUGINS
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"

### FETCH
$HOME/.scripts/fetch.sh
# neofetch
# sfetch

### OPTIONS
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt autocd
unsetopt beep
bindkey -v

### PATH
if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

### ALIASES
if [ -f "$HOME/.aliases" ]; then source "$HOME/.aliases"
fi

### PROMPT
eval "$(starship init zsh)"

### CONDA
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/giuseppe/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/giuseppe/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/giuseppe/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/giuseppe/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

### AUTOJUMP
[[ -s /home/giuseppe/.autojump/etc/profile.d/autojump.sh ]] && source /home/giuseppe/.autojump/etc/profile.d/autojump.sh
