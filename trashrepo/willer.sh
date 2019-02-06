#!/bin/bash

#Finds and kills all wine instances running.

counter=0

supervar=()

while IFS= read -r line; do
    supervar+=( "$line" )
done < <( ps aux | grep -v -E "grep|awk|.sh" | grep wine | awk '{print $2}')

#Prints out the found instances
echo ${supervar[*]}


for i in "${supervar[@]}"; do
		if [[ $i != $$ ]]; then
		kill -9 "$i"
		counter=$((counter+1))
		fi
done

echo $counter processes killed
