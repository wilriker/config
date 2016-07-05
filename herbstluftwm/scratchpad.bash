#!/usr/bin/env bash

# a i3-like scratchpad for arbitrary applications.
#
# this lets a new monitor called "scratchpad" appear in from the top into the
# current monitor. There the "scratchpad" will be shown (it will be created if
# it doesn't exist yet). If the monitor already exists it is scrolled out of
# the screen and removed again.
#
# Warning: this uses much resources because herbstclient is forked for each
# animation step.
#
# If a tag name is supplied, this is used instead of the scratchpad

tag="${1:-scratchpad}"
shift
application="$@"
hc() { "${herbstclient_command[@]:-herbstclient}" "$@" ;}

mrect=( $(hc monitor_rect "" ) )

width=${mrect[2]}
height=${mrect[3]}

rect=(
    $((width/2))
    $((height/2))
    $((${mrect[0]}+(width/4)))
    $((${mrect[1]}+(height/4)))
)

hc add "$tag"

monitor=scratchpad

exists=false
if ! hc add_monitor $(printf "%dx%d%+d%+d" "${rect[@]}") \
                    "$tag" $monitor 2> /dev/null ; then
    exists=true
fi

show() {
    hc chain , \
		lock , \
	    raise_monitor "$monitor" , \
		focus_monitor "$monitor" , \
		unlock , \
		lock_tag "$monitor" , \
		spawn $application
}

hide() {
	hc chain , \
		focus_monitor $monitor , \
		close_or_remove , \
		remove_monitor "$monitor" , \
		merge_tag $tag
}

[ $exists = true ] && hide || show

