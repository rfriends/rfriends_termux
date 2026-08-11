#!/bin/bash -e
#
# restore rfriends3 image for termux
#
# 1.0 2025/05/20 new
# 1.1 2025/05/21 fix
ver=1.1
#
archi=$(dpkg --print-architecture)
echo
echo restore rfriends3 image for termux[ $archi ] Ver. $ver
echo 

if [ "$archi" = 'arm' ]; then
  echo 'arm architecture'
  echo 'このタイプのサポートは終了しました。'
  cpu=v7a
  exit 0
elif [ "$archi" = 'aarch64' ]; then
  echo 'aarch64 architecture'
  cpu=v8a
else
  echo "$archi unknown architecture"
  exit 1
fi

site=https://ss1.xrea.com/rfbuddy.s296.xrea.com/storage
target=/data/data/com.termux/files
dir=/sdcard/Download
fil=termux-backup-$cpu.tar.gz

cd ~/
pkg install -y wget
#echo "wget $site/$fil -O $dir/$fil"
wget $site/$fil -O $dir/$fil

#echo "tar -zxvf $dir/$fil -C $target --recursive-unlink --preserve-permissions"
tar -zxvf $dir/$fil -C $target --recursive-unlink --preserve-permissions

rm $dir/$fil

echo
echo finished
echo
exit 0
