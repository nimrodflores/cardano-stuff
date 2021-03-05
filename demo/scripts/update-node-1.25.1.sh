#!/bin/bash

# get pre-compiled binaries of 1.25.1 and replace the old binaries in /usr/local/bin:
sudo rm -vrf /usr/local/bin/cardano-nod* /usr/local/bin/cardano-cl*
sudo wget https://staking.rocks/stuff/libsodium.a -O /usr/local/lib/libsodium.a
sudo wget https://staking.rocks/stuff/libsodium.la -O /usr/local/lib/libsodium.la
sudo wget https://staking.rocks/stuff/libsodium.so.23.3.0 -O /usr/local/lib/libsodium.so.23.3.0
sudo wget https://staking.rocks/stuff/cardano-node-1.25.1 -O /usr/local/bin/cardano-node-1.25.1
sudo wget https://staking.rocks/stuff/cardano-cli-1.25.1 -O /usr/local/bin/cardano-cli-1.25.1
sudo chmod 775 /usr/local/bin/cardano-cli-1.25.1 /usr/local/bin/cardano-node-1.25.1
sudo chmod 755 /usr/local/lib/libsodium.la /usr/local/lib/libsodium.so.23.3.0
sudo ln -s /usr/local/bin/cardano-cli-1.25.1 /usr/local/bin/cardano-cli
sudo ln -s /usr/local/bin/cardano-node-1.25.1 /usr/local/bin/cardano-node
sudo chmod +x /usr/local/bin/cardano-cli /usr/local/bin/cardano-node
sudo ln -s /usr/local/lib/libsodium.so.23.3.0 /usr/local/lib/libsodium.so
sudo ln -s /usr/local/lib/libsodium.so.23.3.0 /usr/local/lib/libsodium.so.23

# install possibly missing packages:
sudo apt-get install -y tcptraceroute dos2unix

# download the new node config file:
wget https://raw.githubusercontent.com/nimrodflores/cardano-stuff/master/demo/configs/mainnet-config.json -O /home/$USER/cnode/files/mainnet-config.json

# download the new cntools scripts:
wget https://raw.githubusercontent.com/nimrodflores/cardano-stuff/master/demo/scripts/cntools/cntools.config -O /home/$USER/cnode/scripts/cntools.config
wget https://raw.githubusercontent.com/nimrodflores/cardano-stuff/master/demo/scripts/cntools/cntools.library -O /home/$USER/cnode/scripts/cntools.library
wget https://raw.githubusercontent.com/nimrodflores/cardano-stuff/master/demo/scripts/cntools/cntools.sh -O /home/$USER/cnode/scripts/cntools.sh
wget https://raw.githubusercontent.com/nimrodflores/cardano-stuff/master/demo/scripts/cntools/env -O /home/$USER/cnode/scripts/env
wget https://raw.githubusercontent.com/nimrodflores/cardano-stuff/master/demo/scripts/cntools/gLiveView.sh -O /home/$USER/cnode/scripts/gLiveView.sh

# replace `username` in path config:
sed -i "s/username/$USER/" /home/$USER/cnode/scripts/cntools.sh
sed -i "s/username/$USER/" /home/$USER/cnode/scripts/env

# download the new start/stop scripts:
#wget https://raw.githubusercontent.com/nimrodflores/cardano-stuff/master/demo/scripts/cnode-start.sh -O /home/$USER/cnode/scripts/cnode-start.sh
#wget https://raw.githubusercontent.com/nimrodflores/cardano-stuff/master/demo/scripts/cnode-stop.sh -O /home/$USER/cnode/scripts/cnode-stop.sh

# fix file modes:
chmod +x /home/$USER/cnode/scripts/*.sh
chmod +x /home/$USER/cnode/scripts/cntools.library
chmod +x /home/$USER/cnode/scripts/cntools.config

# make sure line characters are converted to LF:
dos2unix /home/$USER/cnode/scripts/cntools.config
dos2unix /home/$USER/cnode/scripts/cntools.library
dos2unix /home/$USER/cnode/scripts/cntools.sh
dos2unix /home/$USER/cnode/scripts/env
dos2unix /home/$USER/cnode/scripts/gLiveView.sh
dos2unix /home/$USER/cnode/scripts/cnode-start.sh
dos2unix /home/$USER/cnode/scripts/cnode-stop.sh

# create /guild-db and shelley_trans_epoch if not yet there:
if [ ! -f "/home/$USER/cnode/guild-db/shelley_trans_epoch" ]; then
    if [ ! -d "/home/$USER/cnode/guild-db" ] then
        mkdir -p /home/$USER/cnode/guild-db
    fi
    touch /home/$USER/cnode/guild-db/shelley_trans_epoch
fi