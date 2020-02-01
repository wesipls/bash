#!/bin/bash

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

