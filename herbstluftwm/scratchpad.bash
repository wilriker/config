#!/usr/bin/env bash

# a i3-like scratchpad for arbitrary applications.
#
# this lets a new monitor called "scratchpad" appear in from the top into the
# current monitor. There the "scratchpad" will be shown (it will be created if
# it doesn't exist yet).
#
# If a tag name is supplied, this is used instead of the scratchpad

tag="${1:-scratchpad}"
shift
application="$@"

mrect=( $(herbstclient monitor_rect "" ) )

width=${mrect[2]}
height=${mrect[3]}

rect=(
	$((width/2))
	$((height/2))
	$((${mrect[0]}+(width/4)))
	$((${mrect[1]}+(height/4)))
)

monitor=scratchpad

herbstclient add "$tag"
if herbstclient add_monitor $(printf "%dx%d%+d%+d" "${rect[@]}") "$tag" $monitor 2> /dev/null; then
	herbstclient chain , \
		lock , \
		raise_monitor "$monitor" , \
		focus_monitor "$monitor" , \
		unlock , \
		lock_tag "$monitor" , \
		spawn $application
else
	herbstclient chain , \
		focus_monitor $monitor , \
		close_or_remove , \
		remove_monitor "$monitor" , \
		merge_tag $tag
fi

