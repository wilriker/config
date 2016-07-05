#!/usr/bin/env fish

herbstclient tag_status $monitor | read -la tags
set -l visible true
set -l windowtitle (herbstclient get_attr clients.focus.title)

set -l color_focused_here_bg (herbstclient get window_border_active_color)
set -l color_focused_here_fg '#101010'
set -l color_focused_there_bg '#d0c9f9'
set -l color_focused_there_fg '#141414'
set -l color_visible_there_bg '#edf2d0'
set -l color_visible_there_fg '#141414'
set -l color_urgent_bg '#ff0675'
set -l color_urgent_fg $color_visible_fg
set -l color_has_window_bg
set -l color_has_window_fg $color_focused_here_bg
set -l color_empty_bg
set -l color_empty_fg '#ababab'

set -l separator "^bg()^fg($selbg)|"

while true

    ### Output ###
    # This part prints dzen data based on the _previous_ data handling run,
    # and then waits for the next event to happen.

    # draw tags
    for tag in $tags
        switch $tag
            case '#*' # the tag is viewed on the specified MONITOR and it is focused
                echo -n "^bg($color_focused_here_bg)^fg($color_focused_here_fg)"
            case '%*' # the tag is viewed on a different MONITOR and it is focused
                echo -n "^bg($color_focused_there_bg)^fg($color_focused_there_fg)"
            case '+*' '-*'
                # [+] the tag is viewed on the specified MONITOR but this monitor is not focused
                # [-] the tag is viewed on a different MONITOR but that monitor is not focused
                echo -n "^bg($color_visible_there_bg)^fg($color_visible_there_fg)"
            case '!*' # the tag contains an urgent window
                echo -n "^bg($color_urgent_bg)^fg($color_urgent_fg)"
            case ':*' # the tag is not empty
                echo -n "^bg($color_has_window_bg)^fg($color_has_window_fg)"
            case '.*' # the tag is empty
                echo -n "^bg($color_empty_bg)^fg($color_empty_fg)"
        end
        set -l tag_name (string sub -s 2 -- $tag)
        echo -n "^ca(1,herbstclient and , focus_monitor $monitor , use '$tag_name') $tag_name ^ca()"
    end
    echo -n "$separator "
    echo "^bg()^fg()"(string replace --all '^' '^^' -- $windowtitle)

    # wait for next event
    read -la cmd
    or break

    # find out event origin
    switch $cmd[1]
        case 'tag*' # resetting tags
            herbstclient tag_status $monitor | read -a tags
        case reload quit_panel
            setsid kill -9 -(getpgid)
            exit
        case togglehidepanel
            set -l currentmonidx (herbstclient get_attr monitors.focus.index)
            if test "$cmd[2]" -ne "$monitor"
                or test "$cmd[2]" = "current" -a "$currentmonidx" -ne "$monitor"
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
        case window_title_changed
            set windowtitle "$cmd[3..-1]"
        case focus_changed
            set windowtitle (herbstclient get_attr clients.focus.title)
    end
end
