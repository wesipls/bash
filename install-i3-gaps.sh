#!/bin/bash
#Short script to install i3-gaps

#Ninja build broken for some reason, using existing github project, thank you  maestrogerardo 
#git clone https://www.github.com/Airblader/i3 i3-gaps
#cd i3-gaps/
#meson build
#ninja -C build/ install


git clone https://github.com/maestrogerardo/i3-gaps-deb.git
cd i3-gaps-deb/
./i3-gaps-deb 

