#!/usr/bin/env fish

set -l monitor_count (herbstclient get_attr monitors.count)
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

set -l tray_icon_count 8
set -l tray_offset (math "$monitor_width - ($panel_height * $tray_icon_count)")

# Put tray only on first monitor
if test $monitor -eq 0

    # Start tray
    set -l tray_geometry $tray_icon_count"x1+"$tray_offset"+0"
    stalonetray --background "$bgcolor" --icon-size $panel_height --icon-gravity NE --geometry $tray_geometry --max-geometry $tray_geometry --kludges force_icons_size &
    echo "started tray with geometry $tray_geometry on monitor $monitor" >>/tmp/herbstluftwm.log
end

# Prepare conkyrc file
set -l conky_gap (math "(($monitor_count - $monitor) * $monitor_width) - $tray_offset")
sed "s/GAPRIGHT/$conky_gap/" "$script_dir/conkyrc" >/tmp/conkyrc.mon$monitor

# Start conky
conky -d -c /tmp/conkyrc.mon$monitor
echo "started conky on monitor $monitor" >>/tmp/herbstluftwm.log

herbstclient --idle | fish $script_dir/event-processor.fish | dzen2 -xs (math $monitor + 1) -e 'onstart=lower' -fn "$font" -h $panel_height -ta l -bg "$bgcolor" -fg '#efefef'
