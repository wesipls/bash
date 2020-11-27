#!/bin/bash

#Check if script is run as superuser
if [ "$EUID" -ne 0 ]
	then echo "This script needs to be run as root"
	exit 1
fi

#Create required directory and fetch resolve script if not already downloaded
mkdir -p /etc/openvpn/scripts
if [ -f "/etc/openvpn/scripts/update-systemd-resolved" ]
then
	echo "The file update-systemd-resolved exists, skipping file download"
else
	wget https://raw.githubusercontent.com/jonathanio/update-systemd-resolved/master/update-systemd-resolved -P /etc/openvpn/scripts/
fi

#Find openvpn file and rewrite startup script
if [ $(ls /etc/openvpn | grep -v "update-resolv-conf" | egrep "*.conf" | wc -l) -eq 1 ]
then
CONFIGFILE=`ls /etc/openvpn | grep -v "update-resolv-conf" | egrep "*.conf"`
	echo "Found openvpn config file $CONFIGFILE"
	sed -i 's/update-resolv-conf/scripts\/update-systemd-resolved/g' /etc/openvpn/$CONFIGFILE
else
	echo "Found multiple or no config file, aborting"
	echo "Check the following thread for how to manually fixing openvpn dns resolution: https://askubuntu.com/questions/1032476/ubuntu-18-04-no-dns-resolution-when-connected-to-openvpn"
	exit 1
fi

#Some final touches, make script executable, reload openvpn and enable autostart
sed -i 's/#AUTOSTART="all"/AUTOSTART="all"/g' /etc/default/openvpn
chmod +x /etc/openvpn/scripts/update-systemd-resolved
systemctl daemon-reload
systemctl restart openvpn
echo "All done, exiting script"
exit 0
