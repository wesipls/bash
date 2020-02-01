#!/bin/bash

#First lesson of https://www.udemy.com/course/bash-scripting/

echo "Shell Scripting is Fun!"

#Check host and echo it to the shell
HOST=$(hostname)
echo "This script is running on ${HOST}. where "${HOST}" is the output of the "hostname" command"
