#!/bin/bash
#Script to copy newest Civ 5 saves from local machine to remote machine
#This script was built for debian buster, most linux steam installation follow the same folder structure

#Color formatting for output
GREEN='\033[0;32m' #Green
NC='\033[0m' # No Color
BLUE='\033[1;34m' #Blue

#Check if remote host available
#TODO, customize remote target (user, address, folder structure"
echo "Assuming remote storage is found on pi@192.168.1.10:/home/pi/Documents/storage/GameSaves/Civ5/"
if ping -c 1 192.168.1.10 &> /dev/null
then
	echo ""
	echo -e "BigPiPi storage set as ${BLUE}/home/pi/Documents/storage/GameSaves/Civ5/${NC}"
	echo ""
#Get 3 newest Civ 5 saves with some bash magic
	cd ~/.local/share/Aspyr/Sid\ Meier\'s\ Civilization\ 5/ModdedSaves/single/
	while read p; do
#Copy gamesaves to target server
	scp "$p" pi@192.168.1.10:/home/pi/Documents/storage/GameSaves/Civ5/
	echo -e "Save file:${GREEN} $p ${NC}has been copied to BigPiPi ${BLUE}Civ5 GameSaves${NC} storage"
	done < <((find . -maxdepth 1 -type f | sort -n | tail -4 | cut -c 3-))
	exit 0
else 
	echo "Remote target not found, please change folder and server in the script"
fi
