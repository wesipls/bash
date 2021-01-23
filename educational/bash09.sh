#!/bin/bash
#Script adds timestamp to .jpg files

shopt -s nullglob
for FILE in $(ls | grep ".*\.jpg$")
do
	mv $FILE $(date +"%Y%m%d").${FILE}
	echo "Timestamp has been added to $FILE"
done
exit 0
