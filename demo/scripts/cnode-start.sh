#!/bin/bash
session="cnode"
START_NODE_CMD="cardano-node run \
--database-path /home/$USER/cnode/db/ \
--socket-path /home/$USER/cnode/socket/socket \
--port 3000 \
--config /home/$USER/cnode/files/mainnet-config.json \
--topology /home/$USER/cnode/files/mainnet-topology.json"

# kill existing session, in case there's any:
killall cardano-node
sleep 3
tmux kill-session -t $session
# create session $session with window "$session":
tmux new -s "$session" -n "$session" -d
# run the cardano-node:
tmux send-keys -t "$session" "$START_NODE_CMD" Enter
# attach to current ssh session:
tmux attach-session -t $session