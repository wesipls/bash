#!/bin/bash
#Third excersize of udemy course, create array and echo them to stdout

ARR=(
	man bear pig dog cat sheep
)

for VAR in "${ARR[@]}"
do
	echo $VAR
done
