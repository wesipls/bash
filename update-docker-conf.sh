#!/bin/bash
#Script to fetch new docker composer and docker config files
#TODO: Rootcheck st beginning

#Fetching docker logging configs 
if [ -f "/etc/docker/daemon.json" ]
then
	echo "Old daemon.json file found, replacing with new version"
	rm -f /etc/docker/daemon.json
fi
wget https://raw.githubusercontent.com/wesipls/cfg/main/daemon.json -P /etc/docker/
systemctl restart docker

#Feching docker compose files
if [ -d "/home/vesipls/" ]
then
	echo "User vesipls found, copying docker-compose.yml files to /home/vesipls/prod/"
	rm /home/vesipls/prod/git/docker-compose.yml
	wget https://raw.githubusercontent.com/wesipls/cfg/main/docker-compose.yml -P /home/vesipls/prod/git/
else
	echo "User vesipls not found, please edit this script and replace, vesipls with username on line 18"
	#TODO: Get username if not vesipls
fi    
