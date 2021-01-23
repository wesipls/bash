#!/bin/bash
#6th excersize in udemy course, check if $1 is file or folder or undefined, each result gives a different exit code.

FILE=$1

if [ -f "$FILE" ]
then
	echo "This is a file"
	exit 0
elif [ -d "$FILE" ]
then
	echo "This is a folder"
	exit 1
else 
	echo "This is something else my dude"
	exit 2
fi
