#!/bin/bash
#4:th excersize of udemy course, checks all given parameters if they are files, folders or something else.

ls -l $@
echo""
if [ -d $@ ]
then
	echo "This right here is a folder!"

elif [ -f $@ ]
then
	echo "This right here is a file!"

elif [ -e $@ ]
then
	echo "This right here is.. a file?"
else
	echo "This aint no file"
fi

