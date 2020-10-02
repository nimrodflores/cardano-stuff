#!/bin/bash
# NOTE: this only works if the node was started using the accompanying script `cnode-start.sh`

session="cnode"

# stop the running cardano-node:
tmux send-keys -t "$session" q
sleep 3

# kill tmux session:
tmux kill-session -t $session
