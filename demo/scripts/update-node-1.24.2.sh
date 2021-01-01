#!/bin/bash

# get pre-compiled binaries of 1.24.2 and replace the old binaries in /usr/local/bin:
sudo rm -vrf /usr/local/bin/cardano-node-* /usr/local/bin/cardano-cli-*
sudo wget https://staking.rocks/stuff/cardano-node-1.24.2 -O /usr/local/bin/cardano-node-1.24.2
sudo wget https://staking.rocks/stuff/cardano-cli-1.24.2 -O /usr/local/bin/cardano-cli-1.24.2
sudo chmod 775 cardano-cli-1.24.2 cardano-node-1.24.2
sudo rm -vrf /usr/local/bin/cardano-cli /usr/local/bin/cardano-node
sudo ln /usr/local/bin/cardano-cli-1.24.2 /usr/local/bin/cardano-cli
sudo ln /usr/local/bin/cardano-node-1.24.2 /usr/local/bin/cardano-node

# download the new node config file:
wget https://raw.githubusercontent.com/nimrodflores/cardano-stuff/master/demo/configs/mainnet-config.json -O /home/$USER/cnode/files/mainnet-config.json

# download the new cntools scripts:
wget https://raw.githubusercontent.com/nimrodflores/cardano-stuff/master/demo/scripts/cntools/cntools.config -O /home/$USER/cnode/scripts/cntools.config
wget https://raw.githubusercontent.com/nimrodflores/cardano-stuff/master/demo/scripts/cntools/cntools.library -O /home/$USER/cnode/scripts/cntools.library
wget https://raw.githubusercontent.com/nimrodflores/cardano-stuff/master/demo/scripts/cntools/cntools.sh -O /home/$USER/cnode/scripts/cntools.sh
wget https://raw.githubusercontent.com/nimrodflores/cardano-stuff/master/demo/scripts/cntools/env -O /home/$USER/cnode/scripts/env
wget https://raw.githubusercontent.com/nimrodflores/cardano-stuff/master/demo/scripts/cntools/gLiveView.sh -O /home/$USER/cnode/scripts/gLiveView.sh

# replace username in path config:
sed -i "s/username/$USER/" /home/$USER/cnode/scripts/cntools.sh
sed -i "s/username/$USER/" /home/$USER/cnode/scripts/env

# download the new start/stop scripts:
wget https://raw.githubusercontent.com/nimrodflores/cardano-stuff/master/demo/scripts/cnode-start.sh -O /home/$USER/cnode/scripts/cnode-start.sh
wget https://raw.githubusercontent.com/nimrodflores/cardano-stuff/master/demo/scripts/cnode-stop.sh -O /home/$USER/cnode/scripts/cnode-stop.sh

# fix file modes:
chmod +x /home/$USER/cnode/scripts/*.sh