#!/usr/bin/env bash
# Opens the whole scrollback of a pane in $EDITOR (zellij's EditScrollback)
#
# usage: edit-scrollback.sh <client> <pane>

file=$(mktemp --suffix=.scrollback)
tmux capture-pane -p -J -S - -t "$2" >"$file"
tmux display-popup -c "$1" -E -w 90% -h 90% -b rounded \
    "${EDITOR:-nvim} + '$file'; rm -f '$file'"
