#!/bin/bash
#7th excersize in udemy course, checks if /etc/shadow file exists using exit codes, exit code 0 stands for succesfull run (file exists) 1-255 stands for error.

cat /etc/shadow

if [ "$?" -eq "0" ]
then
	echo "Command Succeeded"
else
	echo "Command Failed"
fi
