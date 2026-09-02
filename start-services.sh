#!/data/data/com.termux/files/usr/bin/sh
termux-wake-lock
exec runsvdir -P $PREFIX/var/service
