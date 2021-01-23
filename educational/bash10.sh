#!/bin/bash
#For loop generating log entries, 3 random numbers, echo to screen and include pid
for i in {1..3} 
do
	logger -i -s -p user.info $RANDOM
done
