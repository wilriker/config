set -l tags
herbstclient tag_status $monitor | read -a tags
set -l visible true
set -l windowtitle (herbstclient get_attr clients.focus.title)

set -l selbg (herbstclient get window_border_active_color)
set -l selfg '#101010'
set -l bordercolor "#26221C"
set -l separator "^bg()^fg($selbg)|"

while true

    ### Output ###
    # This part prints dzen data based on the _previous_ data handling run,
    # and then waits for the next event to happen.

    # draw tags
    for tag in $tags
        set -l tag_status   (string sub -l 1 -- $tag)
        set -l tag_name     (string sub -s 2 -- $tag)
        switch $tag_status
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
        echo -n '^ca(1,herbstclient focus_monitor '$monitor'; and herbstclient use "'$tag_name'") '"$tag_name ^ca()"
    end
    echo -n "$separator^bg()^fg()"
    echo -n "^bg()^fg(#$nacolor) "(string replace --all '^' '^^' -- $windowtitle)
    echo

    # wait for next event
    set -l cmd
    read -a cmd; or break

    # find out event origin
    switch $cmd[1]
        case 'tag*' # resetting tags
            herbstclient tag_status $monitor | read -a tags
        case reload quit_panel
            kill -9 -$panel_pid
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
