#!/bin/bash
#Asks how many lines of /etc/passwd the user would want to see and prints out numbered lines

echo "How many lines would you like to see?"
read input

#Loop /etc/passwd until count limit is reached
LINE_NUM=1
while read LINE
do
	if [ "$LINE_NUM" -gt "$input" ]
	then
		break
	fi
	echo "${LINE_NUM}: ${LINE}"
	((LINE_NUM++))
done < /etc/passwd 
