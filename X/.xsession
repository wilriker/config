#!/usr/bin/env bash

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Fix keyboard settings
#setxkbmap -layout de -variant nodeadkeys -option caps:none
setxkbmap -layout gb -option caps:none

# Services and tray icons
(sleep 5 && /usr/libexec/mate-notification-daemon) &
(sleep 15 && volumeicon) &
(sleep 25 && gnome-power-manager) &
(sleep 3 && nm-applet) &

# Dropbox
(sleep 15 && DISPLAY=:0 dropboxd) &

xrandr --output HDMI2 --left-of DP2

(sleep 2 && ~/.fehbg) &

exec /usr/bin/env herbstluftwm
