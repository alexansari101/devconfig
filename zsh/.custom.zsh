# Use vi keybindings
bindkey -v
bindkey 'jk' vi-cmd-mode

# Editor
export EDITOR='nvim'

# My aliases
alias ls='exa'
alias ll='exa -Slhga'
alias du='dust'
alias ps='procs'
alias top='btm --color gruvbox'

source /home/alex/.config/broot/launcher/bash/br
alias tree='br -s'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/alex/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/alex/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/alex/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/alex/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

