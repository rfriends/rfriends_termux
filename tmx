#!/bin/sh
#
# easy install friends for termux
#
# 1.0 2025/01/09 new
ver=1.0
#
echo
echo easy install friends for termux Vr. $ver
echo 
#termux-change-repo
pkg update && pkg upgrade -y
pkg install git -y
cd ~/
rm -rf rfriends_termux
git clone https://github.com/rfriends/rfriends_termux.git
cd rfriends_termux
sh rfriends_termux.sh
echo
echo finished

