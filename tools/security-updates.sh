#!/bin/bash
#Check if script is run as superuser
if [ "$EUID" -ne 0 ]
then 
	echo "This script needs to be run as root"
	exit 1
fi

#Checking and updating secuirty sources list
if [ -f "/etc/apt/security.sources.list" ]
then
	grep security /etc/apt/sources.list > original
	cat /etc/apt/security.sources.list > security
	difference=$(diff original security)
	if [ "$difference" != "" ]
	then
		echo "secuirty repositories have been modified in sources.list, updating secuirty source list"
		rm /etc/apt/security.sources.list
		grep security /etc/apt/sources.list | tee /etc/apt/security.sources.list
	fi
else
	echo "No security.sources.list found, generating list"
	grep security /etc/apt/sources.list | tee /etc/apt/security.sources.list
fi
rm original
rm security
echo "Runngin secuirty updates"
apt-get upgrade -o Dir::Etc::SourceList=/etc/apt/security.sources.list
exit 0
