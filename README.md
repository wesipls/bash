Welcome to my collection of bash scripts.
Scripts that are not ready yet are commented wth #TODO
Most scripts are tested on Debian buster and ubuntu bionic.
Most scripts have comments or console echos for what to do if the script is not working.
I enjoy writing bash scripts, if you have any suggestions feel free to contact me.
Any scripts that are non-functional for real cases are found under the educational folder.

I mostly use vesipls as the local user, most likely hard coded in some sections, for other users please run .
cat "script-you-intend-to-use.sh" | grep vesipls
and replace vesipls with your own username
#TODO, create script to replace vesipls with user input, possibly use $USER, wont work for .config files.


Notes:

  deb-init.sh
  only works for debian buster, should not break anything on other distros either, works for ubuntu bionic except for urxvt transparency.

  SendCivData.sh
   only works for static IP address/folder structure, check script for address.
  #TODO add read for user input

  
  i3-gaps-install.sh
  Ninja build errors on ubuntu bionic, works on debian buster.
  #TODO Debug ubuntu bionic
