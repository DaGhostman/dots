#!/usr/bin/env bash
# Keeps the status line visible while a client is unlocked (any mode other
# than LOCKED, or scrolling) and hides it once the client is LOCKED again.
# tmux has no hook for key table changes, so this polls, but only while
# unlocked: it is started by Ctrl g and exits as soon as the client locks.
#
# usage: status-watch.sh <client>

client=$1

state() { tmux display -p -c "$client" '#{client_key_table} #{pane_in_mode} #{client_session}' 2>/dev/null; }

while read -r table scrolling session < <(state); do
    [[ -z $session ]] && exit 0 # client is gone
    if [[ $table == root && $scrolling == 0 ]]; then
        tmux set -t "=$session:" status off
        exit 0
    fi
    sleep 0.1
done
