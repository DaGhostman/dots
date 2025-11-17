alias cat=bat
alias ls=eza
alias tail=tspin
alias grep=rg

if test -f (which fzf); eval "$(fzf --$(basename {$SHELL}))"; end
if test -f (which starship); eval "$(starship init $(basename {$SHELL}))"; end

function ollama -w podman;
    if test -z (podman ps | grep ollama);
        podman run --pull newer --detach --security-opt label=type:container_runtime_t --replace --device=/dev/accel --device /dev/kfd --device /dev/dri -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama:rocm; 
    end

    podman exec -it ollama ollama $argv
end

function openweb-ui -w podman; 
    if test -z (podman ps | grep open-webui);
        podman run --replace --pull newer -d --network=host -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main
    end

    xdg-open http://localhost:8080 &
end
