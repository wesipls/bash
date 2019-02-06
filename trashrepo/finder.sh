#!/bin/bash

# Counts matches of given keyword in given file

counter=0

echo What are we looking for?
read searchterm

echo From what file?
read file

for i in $(cat "$file" | grep -o $searchterm); do
    counter=$((counter+1))
done

echo "$counter"
