#!/usr/bin/env bash
# Entry point for new terminals (ghostty's `command`): picks up a detached
# session when there is one, starts a new session otherwise. Falls back to a
# plain shell when tmux is missing or fails, so the terminal is always usable.

shell=${SHELL:-/bin/bash}
command -v tmux >/dev/null || exec "$shell" -l

session=$(tmux list-sessions -F '#{session_attached} #{session_name}' 2>/dev/null |
    awk '$1 == 0 && $2 !~ /^_float_/ { print $2; exit }')

if [[ -n $session ]]; then
    tmux attach-session -t "=$session" && exit
else
    tmux new-session && exit
fi
exec "$shell" -l
