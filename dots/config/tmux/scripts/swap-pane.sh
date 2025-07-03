#!/usr/bin/env bash

current_pane=$(tmux display-message -p '#{pane_id}')

tmux display-panes -b "run-shell \" \
tmux swap-pane -s $current_pane -t %% \;\
tmux select-pane -t ${current_pane} \
\""
