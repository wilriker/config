#!/usr/bin/env bash

# this is a simple config for herbstluftwm

herbstclient emit_hook reload

# remove all existing keybindings
herbstclient keyunbind --all

# keybindings
Mod=Mod4   # Use the super key as the main modifier
herbstclient keybind $Mod-Shift-q quit
herbstclient keybind $Mod-Shift-r reload
herbstclient keybind $Mod-Shift-c close

# Keybindings to start applications
herbstclient keybind $Mod-Shift-p spawn $HOME/.config/herbstluftwm/restartpanels.bash
herbstclient keybind $Mod-Return spawn st -f "Inconsolata\-g for Powerline:size=11:antialias=true:autohint=true"
herbstclient keybind $Mod-d spawn dmenu_run -i -fn '-*-bitocra' -nb '#1e1e1e' -nf '#888888' -sb '#87afd7' -sf '#1e1e1e'
herbstclient keybind $Mod-e spawn nemo
herbstclient keybind $Mod-c spawn google-chrome-stable
herbstclient keybind $Mod-l spawn slock
herbstclient keybind $Mod-Print spawn scrot
herbstclient keybind $Mod-Alt-r spawn scratchpad "calculator" gnome-calculator

herbstclient set default_frame_layout 3

# tags
herbstclient rename default 1
for tag_name in $(seq 9) ; do
    herbstclient add ${tag_name}
    local key
	key="${tag_name}"
	herbstclient keybind "$Mod-$key" use "${tag_name}"
	herbstclient keybind "$Mod-Shift-$key" move "${tag_name}"
done

# move windows
herbstclient keybind $Mod-Control-Right move_index +1
herbstclient keybind $Mod-Control-Left move_index -1

# cylce through tags
herbstclient keybind $Mod-Right use_index +1 --skip-visible
herbstclient keybind $Mod-Left use_index -1 --skip-visible

# layouting
herbstclient keybind $Mod-r remove
#herbstclient keybind $Mod-space cycle_layout 1
herbstclient keybind $Mod-v split vertical 0.5
herbstclient keybind $Mod-h split horizontal 0.5
herbstclient keybind $Mod-s floating toggle
herbstclient keybind $Mod-f fullscreen toggle
herbstclient keybind $Mod-p pseudotile toggle
# The following cycles through the available layouts within a frame, but skips
# layouts, if the layout change wouldn't affect the actual window positions.
# I.e. if there are two windows within a frame, the grid layout is skipped.
herbstclient keybind $Mod-space                                                           \
            or , and . compare tags.focus.curframe_wcount = 2                   \
                     . cycle_layout +1 vertical horizontal max vertical grid    \
               , cycle_layout +1

# resizing
RESIZESTEP=0.01
herbstclient keybind $Mod-Control-Shift-Left resize left +$RESIZESTEP
herbstclient keybind $Mod-Control-Shift-Down resize down +$RESIZESTEP
herbstclient keybind $Mod-Control-Shift-Up resize up +$RESIZESTEP
herbstclient keybind $Mod-Control-Shift-Right resize right +$RESIZESTEP

# mouse
herbstclient mouseunbind --all
herbstclient mousebind $Mod-Button1 move
herbstclient mousebind $Mod-Button2 resize
herbstclient mousebind $Mod-Button3 zoom

# focus
herbstclient keybind $Mod-Tab cycle_all +1
herbstclient keybind $Mod-Shift-Tab cycle_all -1
herbstclient keybind $Mod-i jumpto urgent
herbstclient keybind $Mod-BackSpace cycle_monitor
herbstclient keybind $Mod-Shift-Left shift left
herbstclient keybind $Mod-Shift-Down shift down
herbstclient keybind $Mod-Shift-Up shift up
herbstclient keybind $Mod-Shift-Right shift right

# Layout
herbstclient attr theme.tiling.reset 1
herbstclient attr theme.floating.reset 1
herbstclient set always_show_frame 1
herbstclient set frame_gap 0
herbstclient set frame_padding 2
herbstclient set frame_bg_transparent 1
herbstclient set frame_transparent_width 2
herbstclient set smart_frame_surroundings 1
herbstclient set window_gap -2
herbstclient set smart_window_surroundings 0
herbstclient set mouse_recenter_gap 0

# theme
herbstclient set frame_border_active_color '#222222'
herbstclient set frame_border_normal_color '#101010'
herbstclient set frame_border_width 1
herbstclient set frame_bg_normal_color '#565656'
herbstclient set frame_bg_active_color '#345F0C'

herbstclient attr theme.active.color '#9fbc00'
herbstclient attr theme.normal.color '#454545'
herbstclient attr theme.urgent.color orange
herbstclient attr theme.inner_width 1
herbstclient attr theme.inner_color black
herbstclient attr theme.border_width 3
herbstclient attr theme.floating.border_width 4
herbstclient attr theme.floating.outer_width 1
herbstclient attr theme.floating.outer_color black
herbstclient attr theme.active.inner_color '#3E4A00'
herbstclient attr theme.active.outer_color '#3E4A00'
herbstclient attr theme.background_color '#141414'

# rules
herbstclient unrule -F
herbstclient rule focus=on # focus new clients

herbstclient rule windowtype~'_NET_WM_WINDOW_TYPE_(DIALOG|UTILITY|SPLASH)' pseudotile=on
herbstclient rule windowtype~'_NET_WM_WINDOW_TYPE_(NOTIFICATION|DOCK|DESKTOP)' manage=off
herbstclient rule windowtype~'_NET_WM_WINDOW_TPYE_(FULLSCREEN|FS)' fullscreen=on
herbstclient rule title='gnome-calculator' pseudotile=on
herbstclient rule title='Connect to MySQL Server' pseudotile=on

# unlock, just to be sure
herbstclient unlock

herbstclient set tree_style '╾│ ├└╼─┐'

# do multi monitor setup here
herbstclient detect_monitors

# tags other monitor
if test $(herbstclient get_attr monitors.count) -gt 1; then
	local tag_names
	tag_names=( $(seq -f '%0.fr' 9) )

	for key in $(seq 9); do
		local index
		index=$(($key - 1))
		herbstclient add "${tag_names[$index]}"
		herbstclient keybind $Mod-Alt-$key use "${tag_names[$index]}"
		herbstclient keybind $Mod-Alt-Shift-$key move "${tag_names[$index]}"
	done
fi

# find the panel
panel=~/.config/herbstluftwm/panel.bash
[ -x "$panel" ] || panel=/etc/xdg/herbstluftwm/panel.sh
for monitor in $(herbstclient list_monitors | cut -d: -f1); do
    # start it on each monitor
    "$panel" $monitor &
done

