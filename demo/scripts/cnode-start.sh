#!/bin/bash
session="cnode"
START_NODE_CMD="cardano-node run \
--database-path /home/$USER/cnode/db/ \
--socket-path /home/$USER/cnode/socket/socket \
--port 3000 \
--config /home/$USER/cnode/files/mainnet-config.json \
--topology /home/$USER/cnode/files/mainnet-topology.json"
START_GLIVE_CMD="/home/$USER/cnode/scripts/gLiveView.sh"

# stop the running gLiveView, if there's any:
tmux send-keys -t "$session:$session.1" q
# stop the running cardano-node, if there's any:
tmux send-keys -t "$session:$session.0" C-c
# give it 5 seconds to shut down
sleep 5
tmux kill-session -t $session

# create session $session with window "$session":
tmux new -s "$session" -n "$session" -d
# split window vertically (left and right):
tmux split-window -h
# run the cardano-node on left pane0:
tmux send-keys -t "$session:$session.0" "$START_NODE_CMD" Enter
sleep 2
# run gLiveView on right pane1:
tmux send-keys -t "$session:$session.1" "$START_GLIVE_CMD" Enter
# attach to current ssh session:
tmux attach-session -t $session