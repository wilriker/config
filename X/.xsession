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
(sleep 2 && start-pulseaudio-x11) &
(sleep 30 && volumeicon) &

# Dropbox
(sleep 15 && DISPLAY=:0 dropboxd) &

# At work
xrandr --output HDMI-2 --primary --left-of DP-2
# At home
# xrandr --output eDP-1 --primary --left-of HDMI-2

(sleep 2 && ~/.fehbg) &

exec /usr/bin/env herbstluftwm
