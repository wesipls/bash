#!/bin/bash

#Script to pull and install vim-plug and nvim configuration file

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

if [ -f "/home/$USER/.config/nvim/init.vim" ]
then
	echo "Old init.vim file found, replacing with new version"
	rm /home/$USER/.config/nvim/init.vim
fi

wget https://raw.githubusercontent.com/wesipls/cfg/main/init.vim -P /home/$USER/.config/nvim/
echo "Run :PlugInstall in the vim editor to install the vim plugins"

exit 0
