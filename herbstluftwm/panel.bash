#!/bin/bash

# disable path name expansion or * will be expanded in the line
# cmd=( ${line} )
set -f

PANEL_PID=$$

hc() { "${herbstclient_command[@]:-herbstclient}" "$@" ;}

monitor=${1:-0}
geometry=( $(herbstclient monitor_rect "${monitor}") )
if [ -z "${geometry}" ] ;then
	echo "Invalid monitor ${monitor}"
	exit 1
fi

# geometry has the format: WxH+X+Y
x=${geometry[0]}
y=${geometry[1]}
monitor_width=${geometry[2]}
panel_height=16

font="-*-*-*-*-*-*-11-*-*-*-*-*-*-*"
bgcolor=$(hc get frame_border_normal_color)
selbg=$(hc get window_border_active_color)
selfg='#101010'

echo "startup monitor ${monitor}" >> /tmp/herbstluftwm.log

herbstclient pad ${monitor} ${panel_height}

# Put conky and tray only on first monitor
if [[ ${monitor} == 0 ]]; then
	tray_icon_count=8
	TRAY_OFFSET=$(echo "${monitor_width} - ${panel_height} * ${tray_icon_count}" | bc)

	# Start tray
	TRAY_GEOMETRY="${tray_icon_count}x1+${TRAY_OFFSET}+0"
	stalonetray --background "${bgcolor}" --icon-size ${panel_height} --icon-gravity NE --geometry ${TRAY_GEOMETRY} --max-geometry ${TRAY_GEOMETRY} --kludges force_icons_size &
	echo "started tray $! on monitor ${monitor}" >> /tmp/herbstluftwm.log

	# Prepare conkyrc file
	[[ ${0} == /* ]] && script="${0}" || script="${PWD}/${0#./}"
	panelfolder=${script%/*}
	if [[ ! -f ${panelfolder}/conkyrc.mon${monitor} ]]; then
		MONITOR_COUNT=$(hc get_attr monitors.count)
		CONKY_GAP=$(((${MONITOR_COUNT} * ${monitor_width}) - ${TRAY_OFFSET}))
		sed "s/GAPRIGHT/${CONKY_GAP}/" "${panelfolder}/conkyrc" > ${panelfolder}/conkyrc.mon${monitor}
	fi

	# Start conky
	conky -d -c "${panelfolder}/conkyrc.mon${monitor}" &>> /tmp/conky.log
	echo "started conky $! on monitor ${monitor}" >> /tmp/herbstluftwm.log
fi

{
	hc --idle
} 2> /dev/null | {
	IFS=$'\t' read -ra tags <<< "$(hc tag_status $monitor)"
	visible=true
	windowtitle=$(herbstclient get_attr clients.focus.title)

	while :; do

		### Output ###
		# This part prints dzen data based on the _previous_ data handling run,
		# and then waits for the next event to happen.

		bordercolor="#26221C"
		separator="^bg()^fg(${selbg})|"
		# draw tags
		for i in "${tags[@]}" ; do
			case ${i:0:1} in
				'#')
					# the tag is viewed on the specified MONITOR and it is focused
					echo -n "^bg(${selbg})^fg(${selfg})"
					;;
				'+')
					# the tag is viewed on the specified MONITOR, but this monitor is not focused
					echo -n "^bg(#edf2d0)^fg(#141414)"
					;;
				':')
					# the tag is not empty
					echo -n "^bg(${selfg})^fg(${selbg})"
					;;
				'!')
					# the tag contains an urgent window
					echo -n "^bg(#FF0675)^fg(#141414)"
					;;
				*)
					# [.] the tag is empty
					# [-] the tag is viewed on a different MONITOR, but this monitor is not focused
					# [%] the tag is viewed on a different MONITOR and it is focused
					echo -n "^bg()^fg(#ababab)"
					;;
			esac
			echo -n "^ca(1,herbstclient focus_monitor ${monitor} && "'herbstclient use "'${i:1}'") '"${i:1} ^ca()"
		done
		echo -n "${separator} "
		echo "^bg()^fg() ${windowtitle//^/^^}"

		# wait for next event
		IFS=$'\t' read -ra cmd || break
		# find out event origin
		case "${cmd[0]}" in
			tag*)
				#echo "resetting tags" >&2
				IFS=$'\t' read -ra tags <<< "$(hc tag_status ${monitor})"
				;;
			reload|quit_panel)
				setsid kill -9 -$(getpgid)
				exit
				;;
			togglehidepanel)
				currentmonidx=$(herbstclient get_attr monitors.focus.index)
				if [ "${cmd[1]}" -ne "${monitor}" ] ; then
					continue
				fi
				if [ "${cmd[1]}" = "current" ] && [ "${currentmonidx}" -ne "${monitor}" ] ; then
					continue
				fi
				echo "^togglehide()"
				if ${visible} ; then
					visible=false
					hc pad ${monitor} 0
				else
					visible=true
					hc pad ${monitor} ${panel_height}
				fi
				;;
			focus_changed)
				windowtitle=$(herbstclient get_attr clients.focus.title)
				;;
			window_title_changed)
				windowtitle="${cmd[@]:2}"
				;;
		esac
	done
} 2> /dev/null | dzen2 -xs $((${monitor} + 1)) -e "onstart=lower" -fn "${font}" -h ${panel_height} -ta l -bg "${bgcolor}" -fg '#efefef'
