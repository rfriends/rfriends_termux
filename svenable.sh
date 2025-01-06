#!/bin/sh
#===========================================================
# svenable
# -----------------------------------------
# install rfriends for termux easy
# -----------------------------------------
# 1.11 2024/07/31 easy
# 2.00 2024/11/03 add lighttpd
#=======================================
echo
echo sv-enable 2.00
echo
echo 以下の5つのコマンドを実行します。
echo
echo sv-enable atd
echo sv-enable crond 
echo sv-enable sshd
echo sv-enable lighttpd
echo termux-wake-lock
echo
#=======================================
sv-enable atd
sv-enable crond
sv-enable sshd
sv-enable lighttpd
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
