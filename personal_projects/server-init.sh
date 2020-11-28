#!/bin/bash
#Init script for new laptops, only works for debian deriatives

#Check if script is run as superuser
if [ "$EUID" -ne 0 ]
then 
	echo "This script needs to be run as root"
	exit 1
fi

#Installing required packages to execute script
apt-get install ca-certificates gnupg-agent apt-transport-https curl git wget -y

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
Packages=(neovim net-tools openssh-server docker-ce docker-ce-cli containerd.io)
for i in ${Packages[@]}
do
	apt-get install $i -y
done

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
if id vesipls >/dev/null 2>&1
then
	usermod -aG docker vesipls
else
	echo "User vesipls does not exist, please give username for docker user:"
	read dockeruser
	usermod -aG docker $dockeruser
fi
#Fetching docker logging configs 
if [ -f "/etc/docker/daemon.json" ]
then
	echo "Old daemon.json file found, replacing with new version"
	rm -f /etc/docker/daemon.json
fi
wget https://raw.githubusercontent.com/wesipls/cfg/main/daemon.json -P /etc/docker/
systemctl restart docker

echo ""
echo "ALL DONE, PLEASE LOGOUT AND BACK IN TO UPDATE USER PERMISSIONS"
exit 0
