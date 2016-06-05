#!/bin/fish

set -l config_dir $HOME/.config
panelcmd="$config_dir/herbstluftwm/panel.fish"

herbstclient emit_hook quit_panel

for i in (herbstclient list_monitors | cut -d':' -f1)
    $panelcmd $i &
end
