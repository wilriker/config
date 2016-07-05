#!/usr/bin/env fish

# a i3-like scratchpad for arbitrary applications.
#
# this lets a new monitor called "scratchpad" appear in from the top into the
# current monitor. There the "scratchpad" will be shown (it will be created if
# it doesn't exist yet).

set -l tag $argv[1]
set -l application $argv[2..-1]

set -l geometry
begin
    set -l IFS ' '
    herbstclient monitor_rect $monitor | read -a geometry
end

set -l width $geometry[3]
set -l height $geometry[4]

set -l rect (math "$width/2")'x'(math "$height/2")'+'(math "$geometry[1]+($width/4)")'+'(math "$geometry[2]+($height/4)")

set -l monitor scratchpad

herbstclient add $tag

if herbstclient add_monitor $rect $tag $monitor ^/dev/null
    herbstclient chain , \
        lock , \
        raise_monitor $monitor , \
        focus_monitor $monitor , \
        lock_tag $monitor , \
        unlock , \
        spawn $application
else
    herbstclient chain , \
        lock , \
        focus_monitor $monitor , \
        close_or_remove , \
        remove_monitor $monitor , \
        merge_tag $tag , \
        unlock
end

