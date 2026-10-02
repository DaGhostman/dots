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
        if [[ -z $(which $1 2>/dev/null) ]]; then
            echo -e "Missing required package {{ pkgs }}"
            return 1;
        fi
    }

    if-not {{ pkgs }}

# Install NeoVim configs
nvim:
    ln -sfn $PWD/nvim ~/.config/nvim

# Configure git (keeps existing user.name & user.email) & SSH Agent
git:
    mkdir -p ~/.ssh
    ln -sfn $PWD/ssh/config ~/.ssh/config
    git config --global --get-all include.path | grep -qxF "$PWD/git/.gitconfig" || git config --global --add include.path "$PWD/git/.gitconfig"

# Configure ripgrep
ripgrep:
    ln -sfn $PWD/ripgrep ~/.config/ripgrep

# Hook shell aliases into the current shell's config
aliases:
    #!/usr/bin/bash
    CURRENT_SHELL="$(basename ${SHELL})"
    LINE="source ${PWD}/aliases/bash.sh"
    if [ "$CURRENT_SHELL" == "zsh" ] || [ "$CURRENT_SHELL" == "bash" ]; then
        RC="$HOME/.${CURRENT_SHELL}rc"
        if grep -qxF "$LINE" "$RC" 2>/dev/null; then
            echo "Already present in $RC"
        else
            echo "Updating $RC"
            echo "$LINE" >> "$RC"
        fi
    elif [ "$CURRENT_SHELL" == "fish" ]; then
        echo "Linking to ~/.config/fish/conf.d/aliases.fish";
        mkdir -p ~/.config/fish/conf.d
        ln -sfn ${PWD}/aliases/fish.fish ~/.config/fish/conf.d/aliases.fish;
    fi
