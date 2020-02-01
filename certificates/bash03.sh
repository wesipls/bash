#!/bin/bash

ARR=(
	man bear pig dog cat sheep
)

for VAR in "${ARR[@]}"
do
	echo $VAR
done
