#!/data/data/com.termux/files/usr/bin/sh
termux-wake-lock
pulseaudio --start --exit-idle-time=-1
smbd -D -s $PREFIX/etc/smb.conf
exec runsvdir -P $PREFIX/var/service
