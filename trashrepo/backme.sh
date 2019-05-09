#!/bin/bash
#Shell script to backup and organize messy users development folders
#All files are backed up to /home/$USER/BACKME, non-directory projects are saved into a folder with the (language)-projects directory
#Example, python projects will be saved to py-projects, javascript will be saved to js-projects
#$1 is the name of the file or folder
#THIS SCRIPT DOES NOT WORK WITH HIDDEN FOLDERS RIGHT NOW, DUE TO '.' DELIMETER BEING USED FOR CUTTING VARIABLES
#TODO: add file compression


#Check and create backup root folder
if [ -d "/home/$USER/BACKME" ] ; then
	echo""
	echo "backme root exists, starting backup..."
else 
	echo""
	echo "backme root not found, creating root..."
	mkdir "/home/$USER/BACKME"
fi

k=$(echo "$1" | rev | cut -d '/' -f 1 | rev)

#Check if $1 is file or folder, and continue accordingly
if [ -d "$1" ] ; then #IF $1 IS FOLDER, TODO: CREATE BACKUPING
	echo ""
	echo "$1 is a folder, backing up into /BACKME/$k..."
	if [ -d "/home/$USER/BACKME/$k" ] ; then
		echo""
		echo" Folder $k already exists, using available folder"
		cp -r $1 /home/$USER/BACKME/$k/${k}_$(date "+%y%m%d%H%M%S")
	else
		echo""
		echo "Folder $k does not exist yet, creating folder"
		mkdir "/home/$USER/BACKME/$k"
		cp -r $1 /home/$USER/BACKME/$k/${k}_$(date "+%y%m%d%H%M%S")
	fi
elif [ -f "$1" ] ; then
	y=$(echo "$1" | rev | cut -d '.' -f 1 | rev)
	echo""
	echo "$1 is a file, backing up, saving in to $y-projects..."
	x=$(echo "$k" | cut -d '.' -f 1)
	if [ -d "/home/$USER/BACKME/$y-projects" ] ; then
		echo""
		echo "$y-projects already exists, digging down..."
			if [ -d "/home/$USER/BACKME/$y-projects/$x" ] ; then
				echo""
				echo "Folder $x in $y-projects already exists, making new entry..."
				cp $1 /home/$USER/BACKME/$y-projects/$x/${k}_$(date "+%y%m%d%H%M%S")
			else
				mkdir "/home/$USER/BACKME/$y-projects/$x"
				echo""
				echo "Folder $x in $y-projects has been created, making new entry..."
				cp $1 /home/$USER/BACKME/$y-projects/$x/${k}_$(date "+%y%m%d%H%M%S")
			fi
	else
		echo""
		echo "$y-projects folder missing, creating folder..."
		mkdir "/home/$USER/BACKME/$y-projects"
			if [ -d "/home/$USER/BACKME/$y-projects/$x" ] ; then
				echo""
				echo "Folder $x in $y-projects already exists, making new entry..."
				cp $1 /home/$USER/BACKME/$y-projects/$x/${k}_$(date "+%y%m%d%H%M%S")
			else
				mkdir "/home/$USER/BACKME/$y-projects/$x"
				echo ""
				echo "Folder $x in $y-projects has been created, making new entry..."
				cp $1 /home/$USER/BACKME/$y-projects/$x/${k}_$(date "+%y%m%d%H%M%S")
			fi
	fi
		

else
	echo""
	echo "!!! Something went wrong, nothing to backup !!!"
fi
echo""
