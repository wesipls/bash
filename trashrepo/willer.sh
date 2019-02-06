#!/bin/bash

#Finds and kills all wine instances running.
#WARNING: Part code, part spaghetti, there is a 1% chance some other PID is killed if started with the PID used by this scripts grep or awk, althought this is a 1-2 second window where this could happend, so dont worry ;)

counter=0

supervar=()

while IFS= read -r line; do
    supervar+=( "$line" )
done < <( ps aux | grep wine | awk '{print $2}' )

for i in "${supervar[@]}"; do
	if [ "$(ps -p $i | tail -n 1 | awk '{print $4}')" != CMD ]; then
		if [[ $i != $$ ]]; then
		kill -9 "$i"
		counter=$((counter+1))
		fi
	fi
done

echo $counter processes killed
