#!/bin/bash
#Install script for scd

#check if ~/bin is available
mkdir /home/$USER/bin

if [ -d ~/bin ]
then
#Create script in bin
	echo "cd \$1;pwd;ls --color=auto -larth" > ~/bin/scd
else
	echo "Bin folder not found, install debian"
	exit 1
fi

#Check if ~/.bashrc is available
if [ -f ~/.bashrc ]
then
#Add alias and export to .bashrc
	echo "export PATH=\$PATH:~/bin" >> ~/.bashrc
	echo 'alias=". ~/bin/scd"' >> ~/.bashrc
else
	echo ".bashrc not found, install debian"
	exit 1
fi

#Make scd executable and source .bashrc
chmod 755 ~/bin/scd
source ~/.bashrc

exit 0
