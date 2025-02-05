#/usr/bin/env bash

if ! tmux list-sessions >/dev/null 2>&1; then
    echo "No tmux sessions found. Starting rtorrent"
    tmux new-session -d -s rtorrent "rtorrent"
else
    # a tmux session is already running -- doing nothing
fi