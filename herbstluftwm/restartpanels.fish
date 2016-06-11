#!/usr/bin/fish

herbstclient emit_hook quit_panel

set -l panel ~/.config/herbstluftwm/panel.fish
for monitor in (herbstclient list_monitors | cut -d: -f1)
    # start it on each monitor
    fish $panel $monitor &
end

