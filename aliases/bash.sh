alias cat=bat
alias ls=eza
alias tail=tspin
alias grep=rg

PATH=${HOME}/.local/bin:$PATH

BREW_PREFIX=${BREW_PREFIX:=/home/linuxbrew/.linuxbrew}

if [[ -f ${BREW_PREFIX}/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [[ -f ${BREW_PREFIX}/bin/fzf ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/fzf --$(basename ${SHELL}))"
fi

if [[ -f ${BREW_PREFIX}/bin/starship ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/starship init $(basename ${SHELL}))"
fi

function ollama() {
    if [[ -z $(podman ps | grep ollama) ]]; then
        podman run --pull newer --detach --security-opt label=type:container_runtime_t --replace --device=/dev/accel --device /dev/kfd --device /dev/dri -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama:rocm; 
    fi

    podman exec -it ollama ollama $@
}

function openweb-ui() {
    if [[ -z $(podman ps | grep open-webui) ]]; then
        podman run --replace --pull newer -d --network=host -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main
    fi

    xdg-open http://localhost:8080 &
}


