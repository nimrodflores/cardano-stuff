#!/bin/bash
# NOTE: this only works if the node was started using the accompanying script `cnode-start.sh`

session="cnode"

# stop the running gLiveView:
tmux send-keys -t "$session:$session.1" q
# stop the running cardano-node:
tmux send-keys -t "$session:$session.0" C-c
# give it 5 seconds to shut down
sleep 5

# kill tmux session:
tmux kill-session -t $session
