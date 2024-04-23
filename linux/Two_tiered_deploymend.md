# Two tiered app deployment

## Application

Refer to Automate_Nginx.md for instructions on how to set up an Nginx web server and Node app.

### Reverse proxy

We would like to access our node app without having to put the port in the URL. This is where reverse proxies come in, where we can redirect a url to another. We simply edit the nginx config file to redirect our url without the port to the one with one:
```bash
sudo sed -i '50s/.*/\t  proxy_pass http:\/\/176.34.208.201:3000;/' /etc/nginx/sites-enabled/default
```

### Export database IP

We also need to connect our app to our database. Ensure before we install the app with `npm install` that we set an environment variable to the IP and port of our database e.g.:
```bash
export DB_HOST=mongodb://172-31-58-181:27017/posts
```

## Database

### Update and upgrade
First update and upgrade our instance:
```bash
sudo apt update -y
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
```
### Install MongoDB
MongoDB is the database which our app will run on. You can find installation instructions for MongoDB on Ubuntu here: https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/#install-mongodb-community-edition

Ensure we download V7.0.6

```bash
sudo apt-get install gnupg curl -y
# prompts to overwrite this, so just remove
sudo rm -f /usr/share/keyrings/mongodb-server-7.0.gpg
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mongodb-org=7.0.6 mongodb-org-database=7.0.6 mongodb-org-server=7.0.6 mongodb-mongosh-shared-openssl3=2.2.4 mongodb-org-mongos=7.0.6 mongodb-org-tools=7.0.6
```

### Bind IP

Now we need to edit our mongodb configuration file so to allow access to our database from certain IPs. For testing purposes we can use 0.0.0.0 (any IP)

```bash
sudo sed -i "s,\\(^[[:blank:]]*bindIp:\\) .*,\\1 0.0.0.0," /etc/mongod.conf
```

### Restart and enable

Restart MongoDB so that changes to our configuration file take place and enable it for convienience

```bash
sudo systemctl restart mongod
sudo systemctl enable mongod

```