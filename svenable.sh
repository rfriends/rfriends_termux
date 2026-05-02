#!/bin/sh
#===========================================================
# svenable
# -----------------------------------------
# install rfriends for termux easy
# -----------------------------------------
# 1.11 2024/07/31 easy
# 2.00 2024/11/03 add lighttpd
# 2.10 2026/02/05 add samba
# 2.11 2026/05/03 add pulseaudio
#=======================================
echo
echo sv-enable 2.11
echo
echo 以下の5つのコマンドを実行します。
echo
echo sv-enable atd
echo sv-enable crond 
echo sv-enable sshd
echo sv-enable lighttpd
echo pulseaudio start
echo smbd -D -s $PREFIX/etc/smb.conf
echo termux-wake-lock
echo
#=======================================
sv-enable atd
sv-enable crond
sv-enable sshd
sv-enable lighttpd
pulseaudio --start --exit-idle-time=-1
smbd -D -s $PREFIX/etc/smb.conf
# 
termux-wake-lock
#
#port=8000
#ip=`sh rfriends3/getIP.sh`
#server=${ip}:${port}
ifconfig | grep "inet " | grep -v "127.0.0.1"
echo
echo ブラウザで、http://IPアドレス:8000 にアクセスしてください。
echo
#===========================================================
