#!/bin/bash
#TODO: CHANGE ENDLESS ELIF STATEMENTS TI CASE SWITCHES

#Changes file delimeters/separators to chosen option
#$1 is target file, example: delimswitcher.sh testfile

#Read user input
echo "What delimeter to change? (Choose number from below)

1(; to Tab)	2(Tab to ;)	3(: to Tab)	4(Tab to :)	5(: to ;)	6(; to :)
"

read reply
echo ""

#Change separator based on user input
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
else
	echo "Please choose a number between 1-6"
	exit 1
fi

exit 0
