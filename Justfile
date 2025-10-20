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
    @just if-not go
    @just if-not node
    @just if-not python3
    @just if-not pipx
    @just if-not git
    @just if-not lazygit
    @just if-not tailspin
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

# Configure git (excl. user.name & user.email) & SSH Agent
git:
    ln -s $PWD/ssh/config ~/.ssh/config
    ln -s $PWD/git/.gitconfig ~/.gitconfig

# Configure ripgrep
ripgrep:
    ln -s $PWD/ripgrep ~/.config/ripgrep

aliases:
    cp $PWD/.aliases ~/.config/.dot-aliases
    echo "You should either `source ~/.dot-aliases` or add it to your shell's rc file (.bashrc, .zshrc, etc.)"
