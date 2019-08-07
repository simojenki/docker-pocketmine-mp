#!/bin/bash

echo "Creating user minecraft($PUID), group minecraft($PGID)"
groupadd -g $PGID minecraft && useradd -r -u $PUID -g minecraft minecraft

echo "Ensuring configuration initialised"
mkdir -p /data/players
mkdir -p /data/worlds
mkdir -p /data/plugins
mkdir -p /data/resource_packs

touch /data/banned-ips.txt
touch /data/banned-players.txt
touch /data/ops.txt
touch /data/white-list.txt
touch /data/server.log

[ ! -e /data/server.properties ] && \
    echo "No existing server.properties, using default" && \
    cat /data/server.properties.default | sed "s/rcon.password=bob/rcon.password=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)/g" > /data/server.properties

[ ! -e /data/pocketmine.yml ] && \
    echo "No existing pocketmine.yml, using default" && \
    cp /minecraft/pocketmine.yml.default /data/pocketmine.yml

echo "Linking /data into /minecraft"
ln -s /data/players /minecraft/players
ln -s /data/worlds /minecraft/worlds
ln -s /data/plugins /minecraft/plugins
ln -s /data/resource_packs /minecraft/resource_packs

ln -s /data/banned-ips.txt /minecraft/banned-ips.txt
ln -s /data/banned-players.txt /minecraft/banned-players.txt
ln -s /data/ops.txt /minecraft/ops.txt
ln -s /data/white-list.txt /minecraft/white-list.txt
ln -s /data/server.log /minecraft/server.log

ln -s /data/pocketmine.yml /minecraft/pocketmine.yml
ln -s /data/server.properties /minecraft/server.properties

chown -R minecraft:minecraft /minecraft
chown -R minecraft:minecraft /data

sudo -H -u minecraft bash -c "/minecraft/start.sh --no-wizard"