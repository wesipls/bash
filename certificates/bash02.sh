#!/bin/bash

if [ -e "/etc/shadow" ]
then
	echo "Shadow passwords are enabled"
	if [ -w "/etc/shadow" ]
	then 
		echo "You have permission to edit /etc/shadow."
	else
		echo "You do NOT have permissions to edit /etc/shadow"
	fi
fi

