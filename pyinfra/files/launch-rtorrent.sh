#/usr/bin/env bash

if ! tmux list-sessions >/dev/null 2>&1; then
    echo "No tmux sessions found. Starting rtorrent"
    tmux new-session -d -s rtorrent "rtorrent"
else
    echo "A tmux session is already running. Doing nothing."
fi