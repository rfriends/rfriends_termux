if ! pgrep -f "termux-wake-lock" > /dev/null; then
    termux-wake-lock
fi

if ! pgrep -f "smbd" > /dev/null; then
    smbd -D -s $PREFIX/etc/smb.conf
fi

if ! pgrep -f "pulseaudio" > /dev/null; then
    pulseaudio --start --exit-idle-time=-1
fi

#port=8000
#ip=`sh rfriends3/getIP.sh`
#server=${ip}:${port}
ifconfig | grep "inet " | grep -v "127.0.0.1"
echo
echo ブラウザで、http://IPアドレス:8000 にアクセスしてください。
echo
