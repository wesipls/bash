#!/bin/bash

/sbin/modprobe -r psmouse & wait
/sbin/modprobe psmouse & wait

if [[ $(/sbin/lsmod | grep 'psmouse') = *psmouse* ]] ; then
	DISPLAY=:0.0 su $USER -c "/usr/bin/notify-send 'Toucpad is running!'"
	exit 0
else 
	DISPLAY=:0.0 su $USER -c "/usr/bin/notify-send 'run: sudo /sbin/modprobe psmouse'"
	exit 1
fi
