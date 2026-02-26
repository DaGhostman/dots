[private]
default:
    @just if-not yazi 
    @just if-not eza 
    @just if-not fzf
    @just if-not bat
    @just if-not hyperfine
    @just if-not starship
    @just if-not zellij
    @just if-not lua
    @just if-not luarocks
    @just if-not git
    @just if-not lazygit
    @just if-not tailspin
    @just --list

[private]
if-not *pkgs:
    #!/usr/bin/bash
    function if-not() {
        if [[ -z $(which $1) ]]; then
            echo -e "Missing required package {{ pkgs }}"
            return 1;
        fi
    }

    if-not {{ pkgs }}

# Install NeoVim configs
nvim:
    ln -s $PWD/nvim ~/.config/nvim

# Configure git (excl. user.name & user.email) & SSH Agent
git:
    ln -s $PWD/ssh/config ~/.ssh/config
    cp $PWD/git/.gitconfig ~/.gitconfig

# Configure ripgrep
ripgrep:
    ln -s $PWD/ripgrep ~/.config/ripgrep

# Bootstrap opencode configuration
[group('llm')]
opencode:
    ln -s $PWD/llm/opencode ~/.config/opencode

# Bootstrap llama-swap configuration
[group('llm')]
llama-swap:
    ln -s $PWD/llm/llama-swap ~/.config/llama-swap
    @just llama-swap-service

# Attempt to install some default models, giving up in ~15 minutes
[group('llm')]
pull-models:
    timeout 15m llama-cli -hf nomic-ai/nimic-embed-text-v1.5-GGUF:Q8_0 --prompt /exit
    timeout 15m llama-cli -hf LiquidAI/LFM2.5-1.2B-Thinking-GGUF:Q4_K_M --prompt /exit
    timeout 15m llama-cli -hf LiquidAI/LFM2-24B-A2B-GGUF:Q4_K_M --prompt /exit
    timeout 15m llama-cli -hf unsloth/Qwen3.5-27B-GGUF:UD-Q4_K_XL --prompt /exit
    timeout 15m llama-cli -hf unsloth/Qwen3.5-35B-A3B-GGUF:MXFP4_MOE --prompt /exit
    timeout 30m llama-cli -hf unsloth/Qwen3-Coder-Next-GGUF:MXFP4_MOE --prompt /exit

# Check if llama.cpp is installed (is llama-server available) and proceeds to pull the default models and setup opencode & llama-swap
[group('llm')]
llm:
    #!/usr/bin/bash
    if [ -z $(which llama-server) ]; then
        echo -e "Llama.cpp does not appear to be installed or is not in $PATH";
        return 1;
    fi
    just pull-models
    just opencode
    just llama-swap
    just llama-swap-service

[private]
[group('services')]
llama-swap-service:
    mkdir -p $HOME/.config/systemd/user
    cp $PWD/services/llama-swap.service $HOME/.config/systemd/user/llama-swap.service
    systemctl enable --user llama-swap --now

aliases:
    #!/usr/bin/bash
    CURRENT_SHELL="$(basename ${SHELL})"
    if [ $CURRENT_SHELL == "zsh" ]; then
        echo "Updating ~/.zshrc"
        echo "source ${PWD}/aliases/bash.sh" >> ~/.zshrc
    elif [ $CURRENT_SHELL == "bash" ]; then
        echo "Updating ~/.bashrc"
        echo "source ${PWD}/aliases/bash.sh" >> ~/.bashrc
    elif [ $CURRENT_SHELL == "fish" ]; then
        echo "Linking to ~/.config/fish/conf.d/aliases.fish";
        ln -s ${PWD}/aliases/fish.fish ~/.config/fish/conf.d/aliases.fish;
    fi
