#!/bin/bash
#Second excersize, checks if shadow passwords are enabled

if [ -e "/etc/shadow" ]
then
	echo "Shadow passwords are enabled"
#Checks user permission to edit the /etc/shadow file
	if [ -w "/etc/shadow" ]
	then 
		echo "You have permission to edit /etc/shadow."
	else
		echo "You do NOT have permissions to edit /etc/shadow"
	fi
fi

