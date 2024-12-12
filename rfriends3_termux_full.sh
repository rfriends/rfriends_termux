#!/bin/sh
# -----------------------------------------
# install rfriends for termux full
# -----------------------------------------
# 1.00 2023/08/01 easy
# 1.01 2023/08/04 add ncpamixer,p7zip
# 1.10 2024/02/24 full
# 1.20 2024/04/08 add samba
# 1.30 2024/10/17 firetv
# 
# toolinstall
# rfriends install
#===========================================================
echo
echo rfriends for termux 1.30
echo
user=`whoami`
dir=`pwd`
userstr="s/rfriendsuser/${user}/g"
echo user is $user .
#===========================================================
pkg update -y 
pkg upgrade -y 

echo
echo install tools
echo

#termux-setup-storage
pkg install termux-services  termux-auth

pkg install -y wget curl unzip p7zip nano vim dnsutils iproute2
pkg install -y ffmpeg atomicparsley php at cronie
#pkg install -y x11-repo
#pkg install -y ffplay
#pkg install -y ncpamixer

#pkg install -y chromium-browser

pkg install -y samba
#pkg install -y lighttpd
#pkg install -y php-cgi
pkg install -y openssh
#===========================================================
echo
echo install rfriends
echo

cd ~/

rm rfriends3_latest_script.zip
wget http://rfriends.s1009.xrea.com/files3/rfriends3_latest_script.zip
unzip -q -o rfriends3_latest_script.zip
#===========================================================
#
# $PREFIX=/data/data/com.termux/files/usr
# $HOME=/data/data/com.termux/files/home
#
#===========================================================
cd ~/
# for cron
mkdir .cache
# for vim
cat <<EOF | tee .vimrc > /dev/null
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac
EOF
#===========================================================
echo
echo configure usrdir
echo
mkdir -p $HOME/storage/shared/music/usr2

cat <<EOF | tee ~/rfriends3/config/usrdir.ini > /dev/null
# Internal media
usrdir="/data/data/com.termux/files/home/storage/shared/music/usr2/"
# microSD
#usrdir="/storage/XXXX-XXXX/usr2/"
#
tmpdir = ""
EOF
#===========================================================
#echo
#echo configure lighttpd
#echo
#cp -p /etc/lighttpd/conf-available/15-fastcgi-php.conf /etc/lighttpd/conf-available/15-fastcgi-php.conf.org
#sed -e ${userstr} $dir/15-fastcgi-php.conf.skel > $dir/15-fastcgi-php.conf
#cp -p $dir/15-fastcgi-php.conf /etc/lighttpd/conf-available/15-fastcgi-php.conf
#chown root:root /etc/lighttpd/conf-available/15-fastcgi-php.conf

#cp -p /etc/lighttpd/lighttpd.conf /etc/lighttpd/lighttpd.conf.org
#sed -e ${userstr} $dir/lighttpd.conf.skel > $dir/lighttpd.conf
#cp -p $dir/lighttpd.conf /etc/lighttpd/lighttpd.conf
#chown root:root /etc/lighttpd/lighttpd.conf

#mkdir -p $HOME/lighttpd/uploads/
#lighttpd-enable-mod fastcgi
#lighttpd-enable-mod fastcgi-php

#systemctl restart lighttpd
#service lighttpd restart
#===========================================================
echo
echo configure samba
echo
mkdir -p $PREFIX/var/log/samba
#chown root.adm /var/log/samba

cd $dir

cp -p $PREFIX/share/doc/samba/smb.conf.example smb.conf
cat smb.conf.skel >> smb.conf
cp -p smb.conf $PREFIX/etc/smb.conf

#systemctl restart smbd nmbd
smbd -D -s $PREFIX/etc/smb.conf
#service smbd restart
#===========================================================
echo -------------------------------------
ip -4 -br a
id
echo
echo "uid=xxx(hogehoge)"
echo
echo "ssh hogehoge@IPaddress -p 8022"
#===========================================================
echo
echo enable service after each reboot
echo
#wake-lock
echo termux-wake-lock
echo sv-enable atd
echo sv-enable crond
echo sv-enable sshd
echo smbd -D -s $PREFIX/etc/smb.conf
#===========================================================
# finish
# -----------------------------------------
echo
echo finished
# -----------------------------------------
