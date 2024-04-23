#!/bin/bash

# put in debian non interactive into commands which install things

#update
echo updating
sudo apt update -y
echo finished updating

#upgrade
echo upgrading
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
echo finished upgrading

# install mongodb v7.0.6 
# (initially you could install the latest version)
echo installing mongodb
sudo apt-get install gnupg curl -y
# prompts to overwrite this, so just remove
sudo rm -f /usr/share/keyrings/mongodb-server-7.0.gpg
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mongodb-org=7.0.6 mongodb-org-database=7.0.6 mongodb-org-server=7.0.6 mongodb-mongosh-shared-openssl3=2.2.4 mongodb-org-mongos=7.0.6 mongodb-org-tools=7.0.6
echo installed mongodb

# configure bind IP in mongodb config file - 0.0.0.0 (anywhere)
# by default only accepts connections from local host (127.0.0.1)
echo configuring bind ip
sudo sed -i "s,\\(^[[:blank:]]*bindIp:\\) .*,\\1 0.0.0.0," /etc/mongod.conf
echo configured bind ip

# restart mongo db (to allow config to take effect)
echo restarting mongodb
sudo systemctl restart mongod
echo restarted mongodb

# enable mongo db
echo enabling mongodb
sudo systemctl enable mongod
echo enabled mongodb