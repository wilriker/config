#!/bin/bash

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Colors
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Fix keyboard settings
setxkbmap -layout de -variant nodeadkeys -option caps:none

# Unset possibly broken variables
#export DESKTOP_SESSION=
export DBUS_SESSION_BUS_ADDRESS=

# Start udiskie
# udiskie --tray &

# Services and tray icons
(sleep 5 && /usr/libexec/notification-daemon) &
(sleep 5 && gnome-volume-control-applet) &
(sleep 15 && gnome-screensaver) &
(sleep 25 && gnome-power-manager) &

# Dropbox
(sleep 15 && DISPLAY=:0 dropbox start) &

# Skype
# (sleep 10 && DISPLAY=:0 skype) &

exec /export/home/mcoenen/bin/herbstluftwm
