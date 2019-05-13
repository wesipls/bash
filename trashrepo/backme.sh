#!/bin/bash
#Shell script to backup and organize messy users development folders
#$1 is the name of the file or folder
#THIS SCRIPT DOES NOT WORK WITH HIDDEN FOLDERS RIGHT NOW, DUE TO '.' DELIMETER BEING USED FOR CUTTING VARIABLES

#Check and create backup root folder
if [ -d "/home/$USER/BACKME" ] ; then
	echo""
	echo "[OK] backme root exists, starting backup..."
else 
	echo""
	echo "[INFO] backme root not found, creating root..."
	mkdir "/home/$USER/BACKME"
fi

#Create new log entry for today if none available
touch "/home/$USER/BACKME/log"
if [ "$(cat /home/$USER/BACKME/log | grep $(date "+%y/%m/%d"))" ] ; then
	:
else
	echo "|#################################|" >> /home/$USER/BACKME/log
	echo "|        $(date "+%y/%m/%d %H:%M:%S")        |" >> /home/$USER/BACKME/log
	echo "|#################################|" >> /home/$USER/BACKME/log
fi

#Check if $1 is a file or folder and save to correct location
##If folder
k=$(basename $1)
if [ -d "$1" ] ; then
	echo ""
	echo "[OK] $1 is a folder, backing up into /BACKME/$k..."
	if [ -d "/home/$USER/BACKME/$k" ] ; then
		echo""
		echo "[OK] Folder $k already exists, using available folder"
		cp -r $1 /home/$USER/BACKME/$k/${k}_$(date "+%y%m%d%H%M%S")
		echo "|" >> /home/$USER/BACKME/log
		echo "|___$(date "+%y/%m/%d %H:%M:%S")    [BACKED UP] FOLDER ${k}_$(date "+%y%m%d%H%M%S") has been saved to the folder $k" >> /home/$USER/BACKME/log
		echo "|______$(date "+%y/%m/%d %H:%M:%S")    [ORGINAL] $1 was backed up" >> /home/$USER/BACKME/log
	else
		echo""
		echo "[INFO] Folder $k does not exist yet, creating folder"
		mkdir "/home/$USER/BACKME/$k"
		cp -r $1 /home/$USER/BACKME/$k/${k}_$(date "+%y%m%d%H%M%S")
		echo "|" >> /home/$USER/BACKME/log
		echo "|___$(date "+%y/%m/%d %H:%M:%S")    [BACKED UP] FOLDER ${k}_$(date "+%y%m%d%H%M%S") has been saved to the folder $k" >> /home/$USER/BACKME/log
		echo "|______$(date "+%y/%m/%d %H:%M:%S")    [ORGINAL] $1 was backed up" >> /home/$USER/BACKME/log

	fi
#Elif File
elif [ -f "$1" ] ; then
	y=$(echo "$1" | rev | cut -d '.' -f 1 | rev)
	echo""
	echo "[OK] $1 is a file, backing up, saving in to $y-projects..."
	x=$(echo "$k" | cut -d '.' -f 1)
	if [ -d "/home/$USER/BACKME/$y-projects" ] ; then
		echo""
		echo "[OK] $y-projects already exists, digging down..."
			if [ -d "/home/$USER/BACKME/$y-projects/$x" ] ; then
				echo""
				echo "[OK] Folder $x in $y-projects already exists, making new entry..."
				cp $1 /home/$USER/BACKME/$y-projects/$x/${k}_$(date "+%y%m%d%H%M%S")
				echo "|" >> /home/$USER/BACKME/log
				echo "|___$(date "+%y/%m/%d %H:%M:%S")    [BACK IN] FILE ${k}_$(date "+%y%m%d%H%M%S") has been saved to the folder $y-projects" >> /home/$USER/BACKME/log
				echo "|______$(date "+%y/%m/%d %H:%M:%S")    [ORGINAL] $1 was backed up" >> /home/$USER/BACKME/log
			else
				mkdir "/home/$USER/BACKME/$y-projects/$x"
				echo""
				echo "[INFO] Folder $x in $y-projects has been created, making new entry..."
				cp $1 /home/$USER/BACKME/$y-projects/$x/${k}_$(date "+%y%m%d%H%M%S")
				echo "|" >> /home/$USER/BACKME/log
				echo "|___$(date "+%y/%m/%d %H:%M:%S")    [BACK IN] FILE ${k}_$(date "+%y%m%d%H%M%S") has been saved to the folder $y-projects" >> /home/$USER/BACKME/log
				echo "|______$(date "+%y/%m/%d %H:%M:%S")    [ORGINAL] $1 was backed up" >> /home/$USER/BACKME/log
			fi
	else
		echo""
		echo "[INFO] $y-projects folder missing, creating folder..."
		mkdir "/home/$USER/BACKME/$y-projects"
			if [ -d "/home/$USER/BACKME/$y-projects/$x" ] ; then
				echo""
				echo "[OK} Folder $x in $y-projects already exists, making new entry..."
				cp $1 /home/$USER/BACKME/$y-projects/$x/${k}_$(date "+%y%m%d%H%M%S")
				echo "|" >> /home/$USER/BACKME/log
				echo "|___$(date "+%y/%m/%d %H:%M:%S")    [BACK IN] FILE ${k}_$(date "+%y%m%d%H%M%S") has been saved to the folder $y-projects" >> /home/$USER/BACKME/log
				echo "|______$(date "+%y/%m/%d %H:%M:%S")    [ORIGINAL] $1 was backed up" >> /home/$USER/BACKME/log
			else
				mkdir "/home/$USER/BACKME/$y-projects/$x"
				echo ""
				echo "[INFO] Folder $x in $y-projects has been created, making new entry..."
				cp $1 /home/$USER/BACKME/$y-projects/$x/${k}_$(date "+%y%m%d%H%M%S")
				echo "|" >> /home/$USER/BACKME/log
				echo "|___$(date "+%y/%m/%d %H:%M:%S")    [BACK IN] FILE ${k}_$(date "+%y%m%d%H%M%S") has been saved to the folder $y-projects" >> /home/$USER/BACKME/log
				echo "|______$(date "+%y/%m/%d %H:%M:%S")    [ORIGINAL] $1 was backed up" >> /home/$USER/BACKME/log
			fi
	fi
		
#Else if no file available
else
	echo""
	echo "[ERROR] !!! Something went wrong, nothing to backup !!!"
	echo "|" >> /home/$USER/BACKME/log
	echo "|___$(date "+%y/%m/%d %H:%M:%S")    [ERROR] Something funky happened, nothing was backed up                                                 [ERROR]" >> /home/$USER/BACKME/log
fi
#Log Disk space usage
d=$(du -sh /home/$USER/BACKME/ | awk -F'\t' '{print $1}')
echo "|_________$(date "+%y/%m/%d %H:%M:%S")    [DISKSPACE] The BACKME/ folder is currently $d in size" >> /home/$USER/BACKME/log
echo""
echo "[CURRENTLY USED DISKPACE]"
echo "$(du -hs /home/$USER/BACKME/* | awk -F'\t' '{print $1 " " $2;}')"
echo""
#Call you a captain when all done
echo "[END] All done captain!"
echo""
