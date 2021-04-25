#!/bin/bash

#USE scdinstall.sh IF YOU DON'T WANT TO CONFIGURE MANUALLY, TESTED ON DEBIAN BUSTER

#SCD = Super Change Directory, cd and list current folder
#Add file to ~/bin/
#Add export PATH=$PATH:~/bin and alias scd =". ~/bin/sdc"
#Remember to chmod 755, run as: scd folder_name

GREEN='\033[0;32m'
NC='\033[0m'

cd $1
pdr=$(pwd)
echo -e "${GREEN} $pdr ${NC}"
ls --color=auto -larth .
