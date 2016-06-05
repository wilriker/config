#!/bin/bash

# this is a simple config for herbstluftwm

hc() {
    herbstclient "$@"
}

hc emit_hook reload

# remove all existing keybindings
hc keyunbind --all

# keybindings
Mod=Mod4   # Use the super key as the main modifier
hc keybind $Mod-Shift-q quit
hc keybind $Mod-Shift-r reload
hc keybind $Mod-Shift-c close

# Keybindings to start applications
hc keybind $Mod-Shift-p spawn ${XDG_CONFIG_HOME:-$HOME/.config}/herbstluftwm/restartpanels.bash
hc keybind $Mod-Return spawn st -f "Inconsolata\-g for Powerline:size=11:antialias=true:autohint=true"
hc keybind $Mod-d spawn dmenu_run -i -fn '-*-bitocra' -nb '#1e1e1e' -nf '#888888' -sb '#87afd7' -sf '#1e1e1e'
hc keybind $Mod-e spawn nemo
hc keybind $Mod-c spawn google-chrome-stable
hc keybind $Mod-l spawn slock
hc keybind $Mod-Print spawn scrot
hc keybind $Mod-Alt-r spawn scratchpad "calculator" gnome-calculator

# KeePass autotype
#hc keybind Control-Alt-a spawn mono /usr/share/keepass/KeePass.exe --auto-type

hc set default_frame_layout 3

# tags
tag_names=( {1..9} )
tag_keys=( {1..9} 0 )

hc rename default "${tag_names[0]}" || true
for i in ${!tag_names[@]} ; do
    hc add "${tag_names[$i]}"
    key="${tag_keys[$i]}"
    if ! [ -z "$key" ] ; then
        hc keybind "$Mod-$key" use "${tag_names[$i]}"
        hc keybind "$Mod-Shift-$key" move "${tag_names[$i]}"
    fi
done

# move windows
hc keybind $Mod-Control-Right move_index +1
hc keybind $Mod-Control-Left move_index -1

# cylce through tags
hc keybind $Mod-Right use_index +1 --skip-visible
hc keybind $Mod-Left use_index -1 --skip-visible

# layouting
hc keybind $Mod-r remove
#hc keybind $Mod-space cycle_layout 1
hc keybind $Mod-v split vertical 0.5
hc keybind $Mod-h split horizontal 0.5
hc keybind $Mod-s floating toggle
hc keybind $Mod-f fullscreen toggle
hc keybind $Mod-p pseudotile toggle
# The following cycles through the available layouts within a frame, but skips
# layouts, if the layout change wouldn't affect the actual window positions.
# I.e. if there are two windows within a frame, the grid layout is skipped.
hc keybind $Mod-space                                                           \
            or , and . compare tags.focus.curframe_wcount = 2                   \
                     . cycle_layout +1 vertical horizontal max vertical grid    \
               , cycle_layout +1

# resizing
RESIZESTEP=0.01
hc keybind $Mod-Control-Shift-Left resize left +$RESIZESTEP
hc keybind $Mod-Control-Shift-Down resize down +$RESIZESTEP
hc keybind $Mod-Control-Shift-Up resize up +$RESIZESTEP
hc keybind $Mod-Control-Shift-Right resize right +$RESIZESTEP

# mouse
hc mouseunbind --all
hc mousebind $Mod-Button1 move
hc mousebind $Mod-Button2 resize
hc mousebind $Mod-Button3 zoom

# focus
hc keybind $Mod-Tab         cycle_all +1
hc keybind $Mod-Shift-Tab   cycle_all -1
hc keybind $Mod-i jumpto urgent
hc keybind $Mod-BackSpace   cycle_monitor
hc keybind $Mod-Shift-Left shift left
hc keybind $Mod-Shift-Down shift down
hc keybind $Mod-Shift-Up shift up
hc keybind $Mod-Shift-Right shift right

# theme
hc attr theme.tiling.reset 1
hc attr theme.floating.reset 1
hc set frame_border_active_color '#222222'
hc set frame_border_normal_color '#101010'
hc set frame_bg_transparent 1
hc set frame_border_width 1
hc set frame_bg_normal_color '#565656'
hc set frame_bg_active_color '#345F0C'
hc set frame_transparent_width 5
hc set always_show_frame 1
hc set frame_gap 1

hc attr theme.active.color '#9fbc00'
hc attr theme.normal.color '#454545'
hc attr theme.urgent.color orange
hc attr theme.inner_width 1
hc attr theme.inner_color black
hc attr theme.border_width 3
hc attr theme.floating.border_width 4
hc attr theme.floating.outer_width 1
hc attr theme.floating.outer_color black
hc attr theme.active.inner_color '#3E4A00'
hc attr theme.active.outer_color '#3E4A00'
hc attr theme.background_color '#141414'

# add overlapping window borders
hc set window_gap -2
hc set frame_padding 2
hc set smart_window_surroundings 0
hc set smart_frame_surroundings 1
hc set mouse_recenter_gap 0

# rules
hc unrule -F
hc rule focus=on # normally focus new clients

hc rule class~'(.*[Rr]xvt.*|.*[Tt]erm|Konsole)' focus=on
hc rule windowtype~'_NET_WM_WINDOW_TYPE_(DIALOG|UTILITY|SPLASH)' pseudotile=on
hc rule windowtype='_NET_WM_WINDOW_TYPE_DIALOG' focus=on
hc rule windowtype~'_NET_WM_WINDOW_TYPE_(NOTIFICATION|DOCK|DESKTOP)' manage=off
hc rule windowtype~'_NET_WM_WINDOW_TPYE_(FULLSCREEN|FS)' fullscreen=on
hc rule title='gnome-calculator' pseudotile=on
hc rule title='Connect to MySQL Server' pseudotile=on

# unlock, just to be sure
hc unlock

hc set tree_style '╾│ ├└╼─┐'

# do multi monitor setup here, e.g.:
# hc set_monitors 1280x1024+0+0 1280x1024+1280+0
# or simply:
hc detect_monitors

# find the panel
panel=~/.config/herbstluftwm/panel.bash
[ -x "$panel" ] || panel=/etc/xdg/herbstluftwm/panel.sh
for monitor in $(hc list_monitors | cut -d: -f1) ; do
    # start it on each monitor
    "$panel" $monitor &
done

# tags other monitor
if [[ `hc list_monitors | wc -l` -gt 1 ]]; then
	tag_names=( 1r 2r 3r 4r 5r 6r 7r 8r 9r )
	tag_keys=( {1..9} 0 )

	for i in ${!tag_names[@]} ; do
		hc add "${tag_names[$i]}"
		key="${tag_keys[$i]}"
		if ! [ -z "$key" ] ; then
			hc keybind $Mod-Alt-$key use "${tag_names[$i]}"
			hc keybind $Mod-Alt-Shift-$key move "${tag_names[$i]}"
		fi
	done
fi

