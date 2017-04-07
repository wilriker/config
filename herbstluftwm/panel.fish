#!/usr/bin/env fish

set -lx monitor 0
if test (count $argv) -ge 1
    set monitor $argv[1]
end
set -l geometry
begin
    set -l IFS ' '
    herbstclient monitor_rect $monitor | read -a geometry
end
if test -z "$geometry"
    echo "Invalid monitor $monitor"
    exit 1
end

# geometry has the format: WxH+X+Y
set -l x $geometry[1]
set -l y $geometry[2]
set -l monitor_width $geometry[3]
set -lx panel_height 16

set -l font "-*-*-*-*-*-*-11-*-*-*-*-*-*-*"
set -l bgcolor (herbstclient get frame_border_normal_color)

echo "startup monitor $monitor" >>/tmp/herbstluftwm.log

herbstclient pad $monitor $panel_height

set -l script_dir (dirname (status -f))

# Put conky and tray only on first monitor
if test $monitor -eq 0
    set -l tray_icon_count 8
    set -l tray_offset (math "$monitor_width - ($panel_height * $tray_icon_count)")

    # Start tray
    set -l tray_geometry $tray_icon_count"x1+"$tray_offset"+0"
    stalonetray --background "$bgcolor" --icon-size $panel_height --icon-gravity NE --geometry $tray_geometry --max-geometry $tray_geometry --kludges force_icons_size &
    echo "started tray with geometry $tray_geometry on monitor $monitor" >>/tmp/herbstluftwm.log

    # Prepare conkyrc file
    if not test -f $script_dir/conkyrc.mon$monitor
        set -l conky_gap (math "($monitor_count * $monitor_width) - $tray_offset")
        sed "s/GAPRIGHT/$conky_gap/" "$script_dir/conkyrc" >$script_dir/conkyrc.mon$monitor
    end

    # Start conky
    conky -d -c "$script_dir/conkyrc.mon$monitor"
    echo "started conky on monitor $monitor" >>/tmp/herbstluftwm.log
end

herbstclient --idle | fish $script_dir/event-processor.fish | dzen2 -xs (math $monitor + 1) -e 'onstart=lower' -fn "$font" -h $panel_height -ta l -bg "$bgcolor" -fg '#efefef'
