#!/bin/bash
#Init script for new servers, only works for debian deriatives

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
Packages=(i3 fonts-firacode rxvt-unicode feh gcc cc clang meson neovim net-tools openssh-server docker-ce docker-ce-cli containerd.io)
for i in ${Packages[@]}
do
	apt-get install $i -y
done

#installing i3-gaps with ./install-i3-gaps.sh
./install-i3-gaps.sh

#Installing docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

#Start and enable services server
systemctl start ssh
systemctl enable ssh
systemctl start docker
systemctl enable docker

#Change default terminal
update-alternatives --set x-terminal-emulator /usr/bin/urxvt

#Configuring docker groups
if grep -q docker /etc/group
then
	echo "group docker already exists, skipping creating group"
else
	groupadd docker	
fi
#Add user to docker group, configure nvim and i3-gaps
if id vesipls >/dev/null 2>&1
then
	usermod -aG docker vesipls
	su -c ./nvim-plugins.sh vesipls
	su -c ./de-configs-update.sh vesipls

else
	echo "User vesipls does not exist, please give username for docker user:"
	read dockeruser
	su -c ./nvim-plugins.sh $dockeruser
	usermod -aG docker $dockeruser
fi

#Replace HandleLidSwitch to keep computer alive with lid closed
LIDSTATUS=$(grep "HandleLidSwitch=" /etc/systemd/logind.conf)
if [ "$LIDSTATUS" != "HandleLidSwitch=ignore" ]
then
	sed -i "s/$LIDSTATUS/HandleLidSwitch=ignore/g" /etc/systemd/logind.conf
fi

echo ""
echo "Please set background image with feh --bg-scale /path/to/image.png, or urxvt background transparency wont work"

exit 0
