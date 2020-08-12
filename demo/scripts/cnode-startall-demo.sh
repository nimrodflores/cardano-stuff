#!/bin/bash

session="demo"
START_NODE_CMD="cardano-node run --database-path /home/nimrod/cnode/db/ --socket-path /home/nimrod/cnode/socket/socket --port 3000 --config /home/nimrod/cnode/files/mainnet-config.json --topology /home/nimrod/cnode/files/mainnet-topology.json"

# kill existing session, in case there's any:
killall cardano-node
sleep 5
tmux kill-session -t $session
# create session $session with window "node":
tmux new -s "$session" -n "$session" -d
# run the cardano-node on left pane:
tmux send-keys -t "$session" "$START_NODE_CMD" Enter
# attach to current ssh session:
tmux attach-session -t $session