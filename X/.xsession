#!/usr/bin/env bash

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Fix keyboard settings
#setxkbmap -layout de -variant nodeadkeys -option caps:none
setxkbmap -layout us -variant altgr-intl -option caps:none

# Unset possibly broken variables
#export DBUS_SESSION_BUS_ADDRESS=

# Services and tray icons
(sleep 5 && /usr/libexec/notification-daemon) &
(sleep 5 && gnome-volume-control-applet) &
(sleep 25 && gnome-power-manager) &
(sleep 3 && nm-applet) &

# Dropbox
(sleep 15 && DISPLAY=:0 dropboxd) &

exec /usr/bin/env herbstluftwm
