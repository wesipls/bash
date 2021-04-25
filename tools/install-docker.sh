#!/bin/bash
#Check if script is run as superuser
if [ "$EUID" -ne 0 ]
then 
	echo "This script needs to be run as root"
	exit 1
fi

#Installing docker-compose, version updated 4/25/2021
curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
#Installing docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

#Start and enable docker service
systemctl start docker
systemctl enable docker

#Configuring docker groups
if grep -q docker /etc/group
then
	echo "group docker already exists, skipping creating group"
else
	groupadd docker	
fi
#Add user to docker group
if id wesipls >/dev/null 2>&1
then
	usermod -aG docker wesipls

else
	echo "User vesipls does not exist, please give username for docker user:"
	read dockeruser
	usermod -aG docker $dockeruser
fi
exit 0
