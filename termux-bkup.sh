#!/bin/bash -e
#
# backup rfriends3 image for termux
#
# 1.0 2025/05/21 new
ver=1.0
#
archi=$(dpkg --print-architecture)
echo
echo backup rfriends3 image for termux( $archi ) Ver. $ver
echo 

if [ "$archi" = 'arm' ]; then
  echo 'arm architecture'
  cpu=v7a
elif [ "$archi" = 'aarch64' ]; then
  echo 'aarch64 architecture'
  cpu=v8a
else
  echo "$archi unknown architecture"
  exit 1
fi

dir=/sdcard/Download
target=/data/data/com.termux/files
fil=termux-backup-$cpu.tar.gz

cd ~/
echo "tar -zcvf $dir/$fil -C $terget ./usr ./home > /dev/null"
#tar -zcvf $dir/$fil -C $terget ./usr ./home > /dev/null

echo
echo finished
echo
exit 0
