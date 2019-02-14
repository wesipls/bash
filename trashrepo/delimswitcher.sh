#!/bin/bash

#Changes file delimeters/separators to chosen option
#First parameter in command is target file, example: delimswitcher.sh testfile
#The rest will be read in during the script

echo "What delimeter to change? (Choose number from below)

1(; to Tab)	2(Tab to ;)	3(: to Tab)	4(Tab to :)	5(: to ;)	6(; to :)
"

read reply

if [ "$reply" == "1" ]; then
	sed -i "s/;/\t/g" $1
	echo "The character ; has now been changed to tab"
elif [ "$reply" == "2" ]; then
	sed -i "s/\t/;/g" $1
	echo "The character tab has now been changed to ;"
elif [ "$reply" == "3" ];then
	sed -i "s/:/\t/g" $1
	echo "The character : has now been changed to tab"
elif [ "$reply" == "4" ];then
	sed -i "s/\t/:/g" $1
	echo "The character tab has now been changed to :"
elif [ "$reply" == "5" ];then
	sed -i "s/:/;/g" $1
	echo "The character : has now been changed to ;"
elif [ "$reply" == "6" ];then
	sed -i "s/;/:/g" $1
	echo "The character ; has now been changed to :"
fi
