#!/bin/bash
#8th excersize in udemy course, requires 1 folder as parameter, if folder is give counts (only) files in folder
#If paramtere $1 is file script will exit with exit code 1

file_count () {
	local VAR="$1"
	echo "${1}:"
	local result=$(ls -p $1| grep -v / | wc | awk '{print $1}')
	echo "There are "$result" files in target folder"
}



if [ -d $1 ]
then
	file_count $1
else
	echo "Enter a folder for count"
	exit 1
fi
