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

sequences_file="${1:-"$HOME/.local/state/caelestia/sequences.txt"}"

if [[ -f "$sequences_file" ]]; then
  sequences=$(<"$sequences_file")

  for pt in /dev/pts/*; do
    basename="$(basename -- "$pt")"
    if [[ "$basename" =~ ^[0-9]+$ ]]; then
      printf '%s' "$sequences" > "$pt" 2>/dev/null || true
    fi
  done
fi

