#! /usr/bin/env bash
SESSION=mri
PORT=8000

tmux -2 new-session -d -s $SESSION
tmux new-window -t $SESSION:1 -n $SESSION
tmux split-window -h -p 20
tmux select-pane -t 0
tmux send-keys "python -m http.server $PORT" C-m
tmux select-pane -t 1
tmux send-keys "sass --watch scss:css" C-m
tmux select-window -t $SESSION:1
tmux select-pane -t 0

open -a "Google Chrome" http://localhost:$PORT
tmux -2 attach-session -t $SESSION

