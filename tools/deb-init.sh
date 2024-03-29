#!/bin/bash
#Init script for new servers, only works for debian deriatives

#Check if script is run as superuser
if [ "$EUID" -ne 0 ]
then 
	echo "This script needs to be run as root"
	exit 1
fi

#Installing required packages to execute script
apt-get install ca-certificates gnupg-agent apt-transport-https curl git wget software-properties-common -y

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
Packages=(i3 fonts-firacode rxvt-unicode feh gcc cc clang meson neovim net-tools openssh-server docker-ce docker-ce-cli containerd.io)
for i in ${Packages[@]}
do
	apt-get install $i -y
done

#Installing docker-compose, version updated 4/25/2021
curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

#Start and enable services server
systemctl start ssh
systemctl enable ssh
systemctl start docker
systemctl enable docker

#Configuring docker groups
if grep -q docker /etc/group
then
	echo "group docker already exists, skipping creating group"
else
	groupadd docker	
fi
#Add user to docker group, configure nvim and i3-gaps
if id wesipls >/dev/null 2>&1
then
	usermod -aG docker wesipls

else
	echo "User vesipls does not exist, please give username for docker user:"
	read dockeruser
	usermod -aG docker $dockeruser
fi
exit 0
