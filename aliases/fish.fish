if test -f (which fzf); eval "$(fzf --$(basename {$SHELL}))"; end
if test -f (which starship); eval "$(starship init $(basename {$SHELL}))"; end

function cat -w bat;
    bat $argv
end

function ls -w eza;
    eza $argv
end

function tail -w tspin;
    tspin $argv
end

function grep -w rg;
    rg $argv
end
