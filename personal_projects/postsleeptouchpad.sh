#!/bin/sh
#Script to start touchpadstart.sh that will re-enable touchpad.
#Files located according to debian busters file locations
case $1 in
  post)
 /usr/local/bin/touchpadstart.sh
  ;;
esac
