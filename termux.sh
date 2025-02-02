#!/bin/bash -e
#
# easy install friends for termux
#
# 1.0 2025/01/09 new
# 1.2 2025/02/03 fix
ver=1.2
#
echo
echo easy install friends for termux Vr. $ver
echo 
#termux-change-repo
#termux-setup-storage
pkg update
pkg install git -y
cd ~/
rm -rf rfriends_termux
git clone https://github.com/rfriends/rfriends_termux.git
cd rfriends_termux
sh rfriends_termux.sh
cd ~/
echo
echo finished
echo
