#!/bin/fish

# disable path name expansion or * will be expanded in the line
# cmd=( ${line} )

set -l panel_pid %self

set -xl monitor
test (count $argv) -ge 1
and set monitor $argv[1]
or set monitor 0
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
set -l panel_height 16

set -l font "-*-*-*-*-*-*-11-*-*-*-*-*-*-*"
set -l bgcolor (herbstclient get frame_border_normal_color)
set -l selbg (herbstclient get window_border_active_color)
set -l selfg '#101010'

echo "startup monitor $monitor" >> /tmp/herbstluftwm.log

herbstclient pad $monitor $panel_height

# Put conky and tray only on first monitor
if test $monitor -eq 12
    set -l tray_icon_count 8
    set -l tray_offset (math "$monitor_width - ($panel_height * $tray_icon_count)")

    # Start tray
    set -l tray_geometry "$tray_icon_count""x1+"$tray_offset"+0"
    stalonetray --background "$bgcolor" --icon-size $panel_height --icon-gravity NE --geometry $tray_geometry --max-geometry $tray_geometry --kludges force_icons_size &
    set -l tray_pid %last
    echo "started tray $tray_pid on monitor $monitor" >>/tmp/herbstluftwm.log

    # Prepare conkyrc file
    set -l panelfolder ~/.config/herbstluftwm
    set -l monitor_count (count (herbstclient list_monitors))
    set -l conky_gap (math "($monitor_count * $monitor_width) - $tray_offset")
    sed "s/GAPRIGHT/$conky_gap/" "$panelfolder/conkyrc" >/dev/shm/conkyrc.mon$monitor

    # Start conky
    conky -d -c "/dev/shm/conkyrc.mon$monitor" >>/tmp/conky.log ^^&1
    echo "started conky $conky_pid on monitor $monitor" >>/tmp/herbstluftwm.log
end

herbstclient --idle ^ /dev/null >| \
begin
    set -l tags
    herbstclient tag_status $monitor | read -a tags
    set -l visible true
    set -l windowtitle (herbstclient get_attr clients.focus.title)

    while true

        ### Output ###
        # This part prints dzen data based on the _previous_ data handling run,
        # and then waits for the next event to happen.

        set -l bordercolor "#26221C"
        set -l separator "^bg()^fg($selbg)|"
        # draw tags
        for tag in $tags
            switch (string sub -l 1 $tag)
                case '#' # the tag is viewed on the specified MONITOR and it is focused
                    echo -n "^bg($selbg)^fg($selfg)"
                case '+' # the tag is viewed on the specified MONITOR, but this monitor is not focused
                    echo -n "^bg(#edf2d0)^fg(#141414)"
                case ':' # the tag is not empty
                    echo -n "^bg($selfg)^fg($selbg)"
                case '!' # the tag contains an urgent window
                    echo -n "^bg(#FF0675)^fg(#141414)"
                case '*'
                    # [.] the tag is empty
                    # [-] the tag is viewed on a different MONITOR, but this monitor is not focused
                    # [%] the tag is viewed on a different MONITOR and it is focused
                    echo -n "^bg()^fg(#ababab)"
            end
            set -l tag_name (string sub -s 2 $tag)
            echo -n '^ca(1,herbstclient focus_monitor '$monitor'; and herbstclient use "'$tag_name'") '"$tag_name ^ca()"
        end
        echo -n "$separator^bg()^fg()"
        echo -n "^bg()^fg(#$nacolor) "(string replace --all '^' '^^' $windowtitle)
        echo

        # wait for next event
        set -l cmd
        read -a cmd; or break

        # find out event origin
        switch $cmd[1]
            case 'tag*' # resetting tags
                herbstclient tag_status $monitor | read -a tags
            case reload quit_panel
                kill -9 -(ps -o pgid= $panel_pid | grep -o '[0-9]*')
                exit
            case togglehidepanel
                set -l currentmonidx (herbstclient list_monitors | grep ' \[FOCUS\]$'| cut -d: -f1)
                if test "$cmd[2]" -ne "$monitor"
                    continue
                end
                if test "$cmd[2]" = "current" -a "$currentmonidx" -ne "$monitor"
                    continue
                end
                echo "^togglehide()"
                if test "true" = "$visible"
                    set visible false
                    herbstclient pad $monitor 0
                else
                    set visible true
                    herbstclient pad $monitor $panel_height
                end
            case focus_changed window_title_changed
                if test (count $cmd) -ge 3
                    set windowtitle "$cmd[3..-1]"
                end
        end
    end
end ^ /dev/null # >| fish dzen2 -xs (math $monitor + 1) -e "onstart=lower" -fn "$font" -h $panel_height -ta l -bg "$bgcolor" -fg '#efefef'
