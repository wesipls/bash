#!/bin/bash

cat /etc/shadow

if [ "$?" -eq "0" ]
then
	echo "Command Succeeded"
else
	echo "Command Failed"
fi
