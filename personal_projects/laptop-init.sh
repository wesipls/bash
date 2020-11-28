#!/bin/bash
#Init script for new laptops, only works for debian deriatives

#Check if script is run as superuser
if [ "$EUID" -ne 0 ]
then 
	echo "This script needs to be run as root"
	exit 1
fi

#CHECK IF SYSTEM IS Debian deriative
DERIATIVE=$(cat /etc/issue | egrep "ebian|buntu|mint")
if [ -z "$DERIATIVE" ]
then
      echo "System not Debian deriative, exiting"
      exit 1
fi

#REPLACE HandleLidSwitch to keep computer running with lid closed
LIDSTATUS=$(grep "HandleLidSwitch=" /etc/systemd/logind.conf)
if [ "$LIDSTATUS" != "HandleLidSwitch=ignore" ]
then
	sed -i "s/$LIDSTATUS/HandleLidSwitch=ignore/g" test
fi

#Updating and installing must have packages
apt-get update
apt-get upgrade -y
 
#Add package to this list to install
Packages=(wget curl git neovim firefox net-tools)

for i in ${Packages[@]}
do
	apt-get install $i -y
done
