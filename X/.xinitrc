##!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# Source the scripts that will be installed by some applications
if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/*; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# Source .xprofile
[ -f /etc/xprofile ] && source /etc/xprofile
[ -f ~/.xprofile ] && source ~/.xprofile

# Start herbstluftwm
exec herbstluftwm
