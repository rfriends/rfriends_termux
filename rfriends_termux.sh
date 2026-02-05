#!/bin/sh
# -----------------------------------------
# install rfriends for termux easy
# -----------------------------------------
# 1.00 2023/08/01 easy
# 1.40 2024/10/23 ip -> ifconfig
# 2.00 2024/11/04 lighttpd,webdav
# 3.00 2024/12/13 for github
# 3.01 2025/01/07 fix
# 3.10 2026/02/05 samba
ver=3.10
#===========================================================
echo
echo rfriends for termux $ver
echo

#PREFIX=/data/data/com.termux/files/usr
#HOME=/data/data/com.termux/files/home
#SITE=https://github.com/rfriends/rfriends3/releases/latest/download
SITE=https://raw.githubusercontent.com/rfriends/rfriends3_core/main
SCRIPT=rfriends3_latest_script.zip
dir=$(cd $(dirname $0);pwd)
#===========================================================
echo
echo ツールをインストール
echo
pkg update -y && pkg upgrade -y 
pkg install -y \
wget curl unzip p7zip nano vim dnsutils iproute2 openssh \
ffmpeg atomicparsley php at cronie \
termux-services termux-auth
#pkg install -y chromium-browser
#===========================================================
echo
echo rfriends3 をインストール
echo

cd $HOME
rm -f $SCRIPT
wget $SITE/$SCRIPT
unzip -q -o $SCRIPT

sed 's/rfriends_name = ""/rfriends_name = "termux"/' $HOME/rfriends3/script/rfriends.ini > $HOME/rfriends3/config/rfriends.ini
#===========================================================
mkdir $HOME/.cache
cp -f $dir/crontab $HOME/rfriends3/script/crontab
cp -f $dir/vimrc $HOME/.vimrc
cp -f $dir/svenable.sh $HOME/svenable.sh
mkdir -p $HOME/storage/downloads/usr
cp -f $dir/usrdir.ini $HOME/rfriends3/config/usrdir.ini
#===========================================================
echo
echo lighttpd + fastcgi + webdav
echo

LCONF=$PREFIX/etc/lighttpd
HTDOCS=$HOME/rfriends3/script/html

pkg install -y lighttpd

mkdir -p $PREFIX/var/log/lighttpd
mkdir -p $PREFIX/var/lib/lighttpd
mkdir -p $PREFIX/var/cache/lighttpd
mkdir -p $HOME/sockets
mkdir -p $HTDOCS/temp
ln -s $HTDOCS/temp $HTDOCS/webdav

mv -n $LCONF/lighttpd.conf $LCONF/lighttpd.conf.org
mv -n $LCONF/modules.conf  $LCONF/modules.conf.org
mv -n $LCONF/conf.d/fastcgi.conf    $LCONF/conf.d/fastcgi.conf.org
mv -n $LCONF/conf.d/webdav.conf     $LCONF/conf.d/webdav.conf.org
mv -n $LCONF/conf.d/dirlisting.conf $LCONF/conf.d/dirlisting.conf.org

cp -f $dir/lighttpd.conf $LCONF/lighttpd.conf
cp -f $dir/modules.conf  $LCONF/modules.conf
cp -f $dir/fastcgi.conf  $LCONF/conf.d/fastcgi.conf 
cp -f $dir/webdav.conf     $LCONF/conf.d/webdav.conf
cp -f $dir/dirlisting.conf $LCONF/conf.d/dirlisting.conf
#===========================================================
echo
echo samba
echo

pkg install -y samba

# samba directory
#
cp $PREFIX/share/doc/samba/smb.conf.example $PREFIX/etc/smb.conf
cat <<EOF | tee -a $PREFIX/etc/smb.conf > /dev/null
#
[smbdir]
comment = termux share folder for rfriends
path = /data/data/com.termux/files/home/storage/downloads/usr2/
read only = no
browsable = yes
guest ok = yes
force user = termux
EOF
#
echo
echo "sambaのためのパスワードを設定してください"
echo
smbpasswd -L -c $PREFIX/etc/smb.conf -a termux
#===========================================================
cp -f $dir/termux.properties $HOME/.termux/.
#===========================================================
echo
echo 1. exit で termux を終了
echo 2. 再度 termux を起動
echo 3. sh svenable.sh を実行
echo
echo finished
#===========================================================
