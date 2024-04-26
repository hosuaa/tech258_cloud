#!/bin/bash
echo updating
sudo apt update -y
echo finished updating

echo upgrading
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
echo finished upgrading

echo installing nginx
sudo DEBIAN_FRONTEND=noninteractive apt install nginx -y
echo finished installing nginx

# configure reverse proxy
echo changing the nginx/sites-enabled/default conf file
sudo sed -i '51s/.*/\t  proxy_pass http:\/\/localhost:3000;/' /etc/nginx/sites-enabled/default
echo changed the nginx/sites-enabled/default conf file

echo restarting nginx
sudo systemctl restart nginx
echo finished restarting nginx

echo enabling nginx
sudo systemctl enable nginx
echo finished enabling nginx

echo installing nodejs v20
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo DEBIAN_FRONTEND=noninteractive -E bash - &&\
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs
echo finished installing nodejs v20

echo checking node version
node -v
echo finished checking node version

# set DB_HOST env var
# ensure ip is the same ip as the db terminal 
# must at least be before npm install
export DB_HOST=mongodb://10.0.3.4:27017/posts

echo getting app folder
# used for user data as it starts in /
cd ~
git clone https://github.com/hosuaa/tech258_sparta_test_app.git
echo got app folder

# git clone https://github.com/hosuaa/tech258_sparta_test_app.git repo
# will git clone the repository into a folder called 'repo' 
# and then you can do cd ~/repo/app

echo going to app folder
cd ~/tech258_sparta_test_app/app
pwd
echo in app folder

echo installing app
npm install
echo finished installing app

echo installing pm2
sudo npm install -g pm2 -y
echo installed pm2

echo stopping previous instances
pm2 stop all
echo stopped previous instances

echo running app
pm2 start app.js
echo done