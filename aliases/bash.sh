alias cat=bat
alias ls=eza
alias tail=tspin
alias grep=rg

PATH=${HOME}/.local/bin:$PATH

if [[ -f $(which fzf) ]]; then
    eval "$(fzf --$(basename ${SHELL}))"
fi

if [[ -f $(which starship) ]]; then
    eval "$(starship init $(basename ${SHELL}))"
fi
