#!/bin/sh
# -----------------------------------------
# install rfriends for termux easy
# -----------------------------------------
# 1.00 2023/08/01 easy
# 1.01 2023/08/04 add ncpamixer,p7zip
# 1.10 2024/07/30 easy
# 1.30 2024/10/17 firetv
# 1.40 2024/10/23 ip -> ifconfig
# 2.00 2024/11/04 lighttpd,webdav
# 3.00 2024/12/13 for github
ver=3.00
# 
# toolinstall
# rfriends install
#===========================================================
echo
echo rfriends for termux $ver
echo

PREFIX=/data/data/com.termux/files/usr
HOME=/data/data/com.termux/files/home
#SITE=http://rfriends.s1009.xrea.com/files3
SITE=https://github.com/rfriends/rfriends3/releases/latest/download
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
#===========================================================
# usrdir.ini
#
mkdir $HOME/storage/downloads/usr
#mkdir $HOME/storage/media-1/usr
#
cat <<EOF | tee $HOME/rfriends3/config/usrdir.ini > /dev/null
; Termux  : ;省略時（ダウンロードディレクトリ）
;           usrdir = "＄HOME/storage/downloads/usr/"
;           ;microSDからは：Android/media/com.termux/
;           usrdir = "＄HOME/storage/media-1/"
;           tmpdir   = ''
; -------------------------------------
[usrdir]
; Internal media
usrdir="＄HOME/storage/downloads/usr/"
;
; microSD
;usrdir = "＄HOME/storage/media-1/"
;
tmpdir = ""
EOF
#===========================================================
# lighttpd + fastcgi + webdav
#===========================================================
LCONF=$PREFIX/etc/lighttpd
HTDOCS=$HOME/rfriends3/script/html

pkg install -y lighttpd

#mkdir $PREFIX/var/run
#mkdir $PREFIX/etc/lighttpd

mkdir $PREFIX/var/log/lighttpd
mkdir $PREFIX/var/lib/lighttpd
mkdir -p $PREFIX/var/cache/lighttpd
mkdir $HOME/sockets

mkdir -p $HTDOCS/temp
ln -s $HTDOCS/temp $HTDOCS/webdav

mv -n $LCONF/lighttpd.conf $LCONF/lighttpd.conf.org
mv -n $LCONF/modules.conf  $LCONF/modules.conf.org
mv -n $LCONF/conf.d/fastcgi.conf    $LCONF/conf.d/fastcgi.conf.org

cd $dir

cp -f lighttpd.conf $LCONF/lighttpd.conf
cp -f modules.conf  $LCONF/modules.conf
cp -f fastcgi.conf  $LCONF/conf.d/fastcgi.conf 

sed -i 's/#webdav.is-readonly/webdav.is-readonly/'       $LCONF/conf.d/webdav.conf
sed -i 's/#webdav.sqlite-db-name/webdav.sqlite-db-name/' $LCONF/conf.d/webdav.conf
sed -i 's/webdav.sqlite-db-name/#webdav.sqlite-db-name/' $LCONF/conf.d/webdav.conf
sed -i 's/#dir-listing.activate/dir-listing.activate/'   $LCONF/conf.d/dirlisting.conf
sed -i 's/#dir-listing.external-css/dir-listing.external-css/' $LCONF/conf.d/dirlisting.conf
#===========================================================
echo
echo 1. exit で termux を終了
echo 2. 再度 termux を起動
echo 3. sh svenable.sh を実行
echo
#===========================================================
# 終了
# -----------------------------------------
echo
echo finished
# -----------------------------------------
