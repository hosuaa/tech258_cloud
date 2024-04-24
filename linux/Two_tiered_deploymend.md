# Two tiered app deployment

## Application

Refer to Automate_Nginx.md for instructions on how to set up an Nginx web server and Node app.

### Reverse proxy

We would like to access our node app without having to put the port in the URL. This is where reverse proxies come in, where we can redirect a url to another. We simply edit the nginx config file to redirect our url without the port to the one with one:
```bash
sudo sed -i '51s/.*/\t  proxy_pass http:\/\/localhost:3000;/' /etc/nginx/sites-enabled/default
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

## Deploy from fresh instances

To deploy the app as quickly as possible, first assume we have two fresh EC2 instances:
1. For the Nginx web server and Node app (allow SSH, HTTP and TCP port 3000)
2. For the Mongo database (allow SSH and TCP port 27017)

- On our database instance, first note down the private IPv4 address and keep it for later.
  - Since I have the bash script to deploy the database saved in my documentation, I simply use nano to create a new `setup.sh` file, copy and paste my script in, then run `chmod 777 setup.sh` to make it executable and run it with `./setup.sh`

- Now on the application instance, I again use nano to create a script file and copy and paste the script from my documentation.
  - Using the IPv4 address from the database instance, I slightly modify the script to change the DB_HOST enivronment variable to that specific IP address. 
- Then I made it executable and ran it.
- After both scripts finish executing, we can navigate to the public IP address of the application instance, and if we go to `/posts`, our database contents will be displayed.
  
## Blockers

I had to learn how to use the `sed` command to rewrite a line, especially since when specifying the line number it does not take into account blanck lines. 

I also got stuck when specifying the IP of the database in the DB_HOST environment variable. I copied the IP from the terminal, which seperates the numbers with `-` rather than `.` (so 172-31-63-51 rather than 172.31.63.51) This was difficult to notice however now that I have made the mistake, I will remember to not do it again. 