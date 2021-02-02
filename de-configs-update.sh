#!/bin/bash
#Script to pull and install desktop environment configs

if [ -f "/home/$USER/.config/i3/config" ]
then
	echo "Old i3 config file found, replacing with new version"
	rm /home/$USER/.config/i3/config
	mkdir -p /home/$USER/.config/i3
fi

wget https://raw.githubusercontent.com/wesipls/cfg/main/i3-config -P /home/$USER/.config/i3/
mv /home/$USER/.config/i3/i3-config /home/$USER/.config/i3/config

if [ -f "/home/$USER/.Xresources" ]
then
	echo "Old .Xresources file found, replacing with new version"
	rm /home/$USER/.Xresources
fi

wget https://raw.githubusercontent.com/wesipls/cfg/main/.Xresources -P /home/$USER/
cd /home/$USER/
xrdb .Xresources
echo "All done, i3 config and xresource has been updated"
exit 0
