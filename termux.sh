#!/bin/bash -e
#
# easy install friends for termux
#
# 1.0 2025/01/09 new
# 1.2 2025/02/03 fix
# 1.3 2026/08/08 fix
ver=1.3
#
echo
echo easy install friends for termux Vr. $ver
echo 
#termux-change-repo
#termux-setup-storage

pkg update
DEBIAN_FRONTEND=noninteractive apt upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"

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
