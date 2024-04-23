# Automate deployment of Nginx Web Server

## Shell scripting

Having created and logged in to our EC2 instance, we can now begin automating the process of deploying our Nginx web server. To accomplish this, we will create a bash script and by running it we can streamline the whole process of setting up Nginx and a Node app with one line.

## Setup.sh

Firstly create a bash script file. Bash scripts end with `.sh`.

### Link to bash
All bash scripts must start with a link to the shell. We use the 'shebang' key (!) to tell linux where the shell is. Bash is usually stored in `/bin/bash`, so we can write:
```bash
#!/bin/bash
```
at the top of our file.

### Update and upgrade
Next, as we have a fresh EC2 instance, it is a good idea to update and upgrade our instance so that we will have the most recent version of Nginx. 

It is safe to update the instance whenever we please as it only updates the source list and does not actually install anything

If we already had infrastructure set up on our instance, we would not want to upgrade the system without testing it first because newer versions may break our code.

We can use `apt` to download and install updates:
```bash
sudo apt update -y
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
```
Note `DEBIAN_FRONTEND=noninteractive` and `-y` are used for automation to remove the need for user input. The `-y` means whenever prompted for yes/no, just automatically put yes and 
`DEBIAN_FRONTEND=noninteractive` is used to remove the pink screen of death terminal locking up due to kernel upgrade.

We would like to see our script actually running, so we put `echo` commands to print when a step has finished successfully e.g:
```bash
echo updating
sudo apt update -y
echo finished updating
```
### Install Nginx
We now have to install our web server, Nginx, and restart it so that our configurations take into effect and enable it so that whenever we load up our instance Nginx runs automatically:

```bash
sudo DEBIAN_FRONTEND=noninteractive apt install nginx -y
sudo systemctl restart nginx
sudo systemctl enable nginx
```

### Install Nodejs
To get a nodejs app running, we have to install nodejs. We want node v20 on ubuntu 22.04, so goto the nodesource docs (https://github.com/nodesource/distributions) and look for the correct version and use the commands given:

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo DEBIAN_FRONTEND=noninteractive -E bash - &&\
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs
```

It is a good idea to check the version of node running for verification purposes: `node -v`


### Get the app code
Now we need to get our application code onto our EC2 instance. There are two ways to accomplish this: send it from our local system to our instance, or download it from our instance.

The first way can be done using scp:
```bash
scp -i ~/.ssh/tech258.pem -r /path/to/local ubuntu@[public_ip]:~/path/to/dest
```
This will not work in our script however. We must upload our app to a GitHub repository and download it from the repo, as the IP is not static and changes from every instance. It also does not have access to our local system.

Once uploaded, we can clone the repo to our EC2 instance:
```bash
git clone https://github.com/hosuaa/tech258_sparta_test_app.git
```

### Goto app
Then we can change directory to where the node app is stored:
```bash
cd ~/tech258_sparta_test_app/app
```

### Install the app and PM2
Once there, the script installs the node app and runs it in the background:
```bash
npm install
```

We can use `npm start` to start the app. However, we would like to use PM2 (process manager 2) to start the app. This is so we can safely start and stop the app when running the script multiple times: PM2 is smart and knows how to stop apps before any app has started

```bash
sudo npm install -g pm2 -y
pm2 stop all
pm2 start app.js
```

We could optionally name our app after the start command: `pm2 start app.js app` and so we could directly stop this app with `pm2 stop app`. This could be useful when running multiple apps on our instance. 


The node app can now be accessed from the public IP address of the EC2 instance followed by port 3000

By adding these lines of code to a script, we can run it and the entire process is encapsulated into one line of code: calling the script. It can be ran as many times as we wish without breaking anything (it is idempotent)
