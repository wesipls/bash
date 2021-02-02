#!/bin/bash
#Short script to install i3-gaps

git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps/
meson build
ninja -C build/ install
