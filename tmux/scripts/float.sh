#!/usr/bin/env bash
# Zellij-style floating panes for tmux.
#
# Every window can own a hidden "_float_<window id>" session: its floating
# layer. The layer is shown in a popup on top of the window and every window
# inside the layer is one floating pane (Alt h/l cycles through them).
#
# usage: float.sh toggle|embed|fullscreen <client> <session> <window> <pane> <cwd>
#        float.sh gc

PREFIX=_float_
SIZE=${TMUX_FLOAT_SIZE:-80%}

action=$1
client=${2:-} session=${3:-} window=${4:-} pane=${5:-} cwd=${6:-$HOME}

layer_of() { echo "${PREFIX}${1#@}"; }
is_layer() { [[ $1 == "$PREFIX"* ]]; }
exists() { tmux has-session -t "=$1" 2>/dev/null; }

# Creates the layer of $window with a fresh shell, prints the placeholder window id
create_layer() {
    local layer=$1
    tmux new-session -d -s "$layer" -c "$cwd" -P -F '#{window_id}'
    tmux set -t "=$layer:" @float_parent "$window"
    tmux set -w -t "$window" @float 1
}

# Shows the layer on $client
show() {
    local layer=$1 size=$SIZE
    [[ $(tmux show -qv -t "=$layer:" @float_full) == 1 ]] && size=100%
    tmux set -t "=$layer:" @float_client "$client"
    tmux display-popup -c "$client" -E -w "$size" -h "$size" -b rounded \
        -T '#[align=centre] floating ' \
        "env -u TMUX tmux -S '${TMUX%%,*}' attach -t '=$layer'"
}

# -h when the target pane is wide, -v when it is tall (like zellij's NewPane)
split_flag() {
    [[ $(tmux display -p -t "$1" '#{e|>:#{pane_width},#{e|*:#{pane_height},2}}') == 1 ]] && echo -h || echo -v
}

case $action in
toggle)
    if is_layer "$session"; then
        tmux detach-client -t "$client"
    else
        layer=$(layer_of "$window")
        exists "$layer" || create_layer "$layer" >/dev/null
        show "$layer"
    fi
    ;;

embed) # floating pane -> pane of the parent window, tiled pane -> floating pane
    if is_layer "$session"; then
        parent=$(tmux show -qv -t "=$session:" @float_parent)
        outer=$(tmux show -qv -t "=$session:" @float_client)
        tmux join-pane "$(split_flag "$parent")" -s "$pane" -t "$parent"
        exists "$session" && tmux display-popup -C -c "$outer"
    else
        if [[ $(tmux display -p -t "$pane" '#{window_panes}') -le 1 ]]; then
            tmux display-message -c "$client" "Can't float the only pane of a window"
            exit 0
        fi
        layer=$(layer_of "$window")
        placeholder=
        exists "$layer" || placeholder=$(create_layer "$layer")
        new=$(tmux break-pane -d -s "$pane" -t "=$layer:" -P -F '#{window_id}')
        [[ -n $placeholder ]] && tmux kill-window -t "$placeholder"
        tmux select-window -t "$new"
        show "$layer"
    fi
    ;;

fullscreen) # toggle the floating layer between 80% and the whole screen
    is_layer "$session" || exit 0
    full=$(tmux show -qv -t "=$session:" @float_full)
    tmux set -t "=$session:" @float_full "$([[ $full == 1 ]] && echo 0 || echo 1)"
    client=$(tmux show -qv -t "=$session:" @float_client)
    tmux display-popup -C -c "$client"
    show "$session"
    ;;

gc) # drop layers whose window is gone and markers of layers that are gone
    windows=$(tmux list-windows -a -F '#{window_id}')
    tmux list-sessions -F '#{session_name} #{@float_parent}' | while read -r name parent; do
        is_layer "$name" || continue
        grep -qxF "$parent" <<<"$windows" || tmux kill-session -t "=$name"
    done
    tmux list-windows -a -F '#{window_id} #{@float}' | while read -r id flag; do
        [[ $flag == 1 ]] && ! exists "$(layer_of "$id")" && tmux set -wu -t "$id" @float
    done
    ;;
esac
exit 0
