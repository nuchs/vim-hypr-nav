#!/bin/sh
#
# vim-sway-nav - Use the same bindings to move focus between sway windows and
# vim splits. Requires the accompanying vim plugin.

dir="$1"

case "$dir" in
    up) ;;
    right) ;;
    down) ;;
    left) ;;
    *)
        echo "USAGE: $0 up|right|down|left"
        exit 1
esac

get_descendant_vim_pid() {
    pid="$1"
    terms="$2"

    if grep -iqE '^g?(view|n?vim?x?)(diff)?$' "/proc/$pid/comm"; then
        if embed_pid="$(pgrep --parent "$pid" --full 'nvim --embed')"; then
            echo "$embed_pid"
        else
            echo "$pid"
        fi

        return 0
    fi

    for child in $(pgrep --runstates D,I,R,S --terminal "$terms" --parent "$pid"); do
        if get_descendant_vim_pid "$child" "$terms"; then
            # already echo'd PID in recursive call
            return 0
        fi
    done

    return 1
}

if focused_pid="$(swaymsg -t get_tree | jq -e '.. | select(.focused? == true).pid')"; then
    terms="$(find /dev/pts -type c -not -name ptmx | sed s#^/dev/## | tr '\n' ,)"
    if vim_pid="$(get_descendant_vim_pid "$focused_pid" "$terms")"; then
        servername_file="${XDG_RUNTIME_DIR:-/tmp}/vim-sway-nav.$vim_pid.servername"
        read -r program servername <"$servername_file"

        if [ "$program" = vim ]; then
            serverarg=--servername
        elif [ "$program" = nvim ]; then
            serverarg=--server
        fi

        if [ -n "$serverarg" ] && [ -n "$servername" ]; then
            "$program" "$serverarg" "$servername" \
                --remote-expr "VimSwayNav('$dir')" >/dev/null 2>&1 \
                && exit 0
        fi
    fi
fi

swaymsg focus "$dir"
