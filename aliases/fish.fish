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

set sequences_file "$HOME/.local/state/caelestia/sequences.txt"  
  
if test -f "$sequences_file"  
    set sequences (cat "$sequences_file")  
      
    # Write to each pseudo-terminal  
    for pt in /dev/pts/*  
        set basename (basename "$pt")  
        if string match -qr '^\d+$' -- "$basename"  
            echo -n "$sequences" > "$pt" 2>/dev/null; or true  
        end  
    end  
end

export MINIMAX_API_KEY=$(cat $HOME/.local/share/opencode/auth.json | jq -r '.["minimax-coding-plan"].key')
