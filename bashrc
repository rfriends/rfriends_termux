if ! pgrep -f "termux-wake-lock" > /dev/null; then
    termux-wake-lock
fi

if ! pgrep -f "smbd" > /dev/null; then
    smbd -D -s $PREFIX/etc/smb.conf
fi

if ! pgrep -f "pulseaudio" > /dev/null; then
    pulseaudio --start --exit-idle-time=-1
fi
