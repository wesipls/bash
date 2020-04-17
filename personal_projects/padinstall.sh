#!/bin/bash
#Installation script for touchpad re-enabling after sleep
#TODO, script works, needs a lot of error handling
target="/lib/systemd/system-sleep/"

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root, the generated file needs root rights for running at wake up" 1>&2
   exit 1
fi

if [ -d $target ]; then
	printf "#!/bin/sh
#Script to start touchpadstart.sh that will re-enable touchpad.
#Files located according to debian busters file locations
case \$1 in
  	post)
 	/usr/local/bin/touchpadstart.sh
  	;;
esac
" >> postpad.sh
else 
	echo "/lib/systemd/system-sleep/ not found, please specify installation folder"
fi
