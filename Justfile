[private]
default:
    @just if-not yazi 
    @just if-not eza 
    @just if-not fzf
    @just if-not bat
    @just if-not hyperfine
    @just if-not starship
    @just if-not zellij
    @just if-not lua luarocks
    @just if-not go
    @just if-not node
    @just if-not python3 pipx
    @just --list

[private]
if-not *pkgs:
    #!/usr/bin/bash
    function if-not() {
        if [[ -z $(which $1) ]]; then
            echo "Installing {{ pkgs }} as it does not exist"
            just brew $@
        fi
    }

    if-not {{ pkgs }}

# Install packages using brew
[group('utils')]
brew *pkgs:
    #!/usr/bin/bash
    function brew() {
        if [[ -z $(which brew) ]]; then
            echo -e "Brew is not installed, you should install it follwoing the instructions at https://docs.brew.sh/Installation"
        fi

        /home/linuxbrew/.linuxbrew/bin/brew install $@
    }

    brew {{ pkgs }}

# Install NeoVim configs
nvim:
    ln -s $PWD/nvim ~/.config/nvim

# Configure git (excl. user.name & user.email)
git:
    ln -s $PWD/git/.gitconfig ~/.gitconfig

ripgrep:
    ln -s $PWD/ripgrep ~/.config/ripgrep
