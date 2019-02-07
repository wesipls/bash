#!/bin/bash

#Finds and kills all instances running by keyword

counter=0
supervar=()

#Find running instances

while IFS= read -r line; do
    supervar+=( "$line" )
done < <( ps aux | grep -v -E "grep|awk|procdrop" | grep $1 | awk '{print $2}')

#Prints out the found instances

echo ""
echo "$(ps aux | grep -v -E "grep|awk|procdrop" | grep $1 | awk '{print $2, $11}')"
echo ""

#Kill running instances

for i in "${supervar[@]}"; do
		if [[ $i != $$ ]]; then
		kill -9 "$i"
		counter=$((counter+1))
		fi
done



echo $counter processes killed
echo ""
