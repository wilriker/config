#!/usr/bin/env fish

# a i3-like scratchpad for arbitrary applications.
#
# this lets a new monitor called "scratchpad" appear in from the top into the
# current monitor. There the "scratchpad" will be shown (it will be created if
# it doesn't exist yet).

set -l tag $argv[1]
set -l application $argv[2..-1]

herbstclient monitor_rect | read -al geometry

set -l x $geometry[1]
set -l y $geometry[2]
set -l width $geometry[3]
set -l height $geometry[4]

set -l rect (math "$width/2")'x'(math "$height/2")'+'(math "$x+($width/4)")'+'(math "$y+($height/4)")

set -l monitor scratchpad-for-$application[1]

if herbstclient and + add $tag + add_monitor $rect $tag $monitor 2>/dev/null
    herbstclient chain , \
        lock , \
        new_attr int monitors.by-name.$monitor.my_prev_focus , \
        substitute M monitors.focus.index set_attr monitors.by-name.$monitor.my_prev_focus M , \
        raise_monitor $monitor , \
        focus_monitor $monitor , \
        lock_tag $monitor , \
        unlock , \
        floating $tag on

    if test $application[1] = st
        st $application[2..-1]
    else
        eval $application
    end
else
    # TODO: Remove this else block as soon as I am used to the new flow
    if command -sq notify-send
        notify-send "Close the app!"
    end
    exit
end
herbstclient chain , \
    lock , \
    focus_monitor $monitor , \
    close , \
    substitute M monitors.by-name.$monitor.my_prev_focus focus_monitor M , \
    remove_monitor $monitor , \
    merge_tag $tag , \
    unlock
