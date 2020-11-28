#!/bin/bash
#Init script for new laptops, only works for debian deriatives

#Check if script is run as superuser
if [ "$EUID" -ne 0 ]
then 
	echo "This script needs to be run as root"
	exit 1
fi

#Installing required packages to execute script
apt-get install apt-transport-https curl git wget -y

#Adding docker repository
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
#Updating and upgrading packages
apt-get update
apt-get upgrade -y

#Add package to this list to install
Packages=(ca-certificates gnupg-agent software-properties neovim firefox net-tools openssh-server docker-ce docker-ce-cli containered.io)
for i in ${Packages[@]}
do
	apt-get install $i -y
done

#Start and enable ssh server
systemctl start ssh
systemctl enable ssh

