#!/bin/bash
#Prints all running processes based on keyword, where $1 is the keyword, Example: procdrop.sh steam
#To kill all found processes, make $2 parameter end, Example: procdrop.sh steam end

#Finds all running processes
supervar=()
while IFS= read -r line; do
    supervar+=( "$line" )
    counter=$((counter+1))
done < <( ps aux | grep -v -E "grep|awk|procdrop" | grep $1 | awk '{print $2}')

#If no processes are found, inform the user and exit with error 1
if [ -z "$counter" ]; then
	echo "ERROR: No processes with keyword $1 found"
	exit 1
else

#Print out result (The script will exclude processes started by itself, including $0)
	echo""
	echo -e "PID\t%CPU\t%MEM\tINSTANCE"
	echo "--------------------------------"
	ps aux | grep -v -E "grep|awk|procdrop" | grep $1 | awk '{print $2, $3, $4, $11, $12, $13}' | tr " " "\t"
	echo "--------------------------------"
	echo""
fi

#If parameter $2 was set as end, kills all found processes
if [ "$2" == "end" ]; then
	#Kill running instances
	for i in "${supervar[@]}"; do
			if [[ $i != $$ ]]; then
			kill -9 "$i"
			fi 
	done
	echo "$counter processes found and $counter processes killed"
else
	echo "No processes killed, add end to kill found processes, example: ./procdrop.sh steam end"
fi

