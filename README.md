# Deploying a virtual machine on AWS

## 1. Log into AWS and go to EC2

- explain what an ec2 is

![image](images/goto_ec2.png)

## 2. Press 'Launch instance'

![image](images/launch_instance.png)

## 3. Fill in the necessary information

- Name your EC2 instance (use a suitable naming convention)
- Choose the OS image
    - explain OS images
    - For each OS image, there is many Amazon machine images (AMIs). Choose the AMI, ensuring you only get what is necessary as it can get expensive. If a free tier is available, try to go for that one

![image](images/ami.png)

- Choose the instance type. Different types provide different hardware and prices, with more expensive ones having more memory and CPU. Again, only get what is necessary and aim for free tiers.

![image](images/instance_type.png)

- Give a key pair to login to the instance
    - explain ssh keys

![image](images/key_pair.png)

- Edit the network settings
    - explain security groups and ports

![image](images/edit_network_settings.png)

- Edit the security groups, and add a rule for HTTP
    - Ensure the security groups have descriptive names and follow a suitable convention
    - We need to add a rule for HTTP so that we can access our web server from the internet

![image](images/edit_2.png)

![image](images/http_sg.png)

- Check your summary looks similar to the picture below. If so, launch your instance with the button.

![image](images/summary.png)

## Connect your instance

![image](images/instance_id.png)

![image](images/connect.png)

Once you press connect, navigate to SSH client. You can now open an SSH client (such as Git Bash), and input the following commands to connect to your instance.

![image](images/connect_2.png)

Your private key should ALWAYS be in your `.ssh` folder and secure from everybody

![image](images/ssh_connect.png)

After running, you should be connected to your instance, with the username 'ubuntu'

![image](images/ubuntu.png)

## Install nginx

Firstly, ensure your system is fully updated by running
```
sudo apt update -y
sudo apt upgrade -y
```

![image](images/update.png)

![image](images/upgrade.png)

Now install nginx with `sudo apt install nginx -y`

![image](images/nginx.png)

Nginx is our web server, and it should be running by default. To check it is running, run `systemctl status nginx`

![image](images/nginx_2.png)

Press q to quit that. We can now access our webpage by typing the IP given on our AWS instance page into the search bar.

