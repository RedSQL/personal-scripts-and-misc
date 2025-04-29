#!/usr/bin/env bash
temp_file="/tmp/zoomed_in.lock"
err() { echo "$@" | logger -s -t "Center zoom" -p user.err; }
warn() { echo "$@" | logger -s -t "Center zoom" -p user.warn; }
info() { echo "$@" | logger -s -t "Center zoom" -p user.info; }
ZOOM_IN_AMOUNT=20
ZOOM_OUT_AMOUNT=25
function determine_screen {
	local scrn_info
	local scrn_n
	local scrn_cur_mode_id
	local scrn_W
	local scrn_H
	scrn_info=$(kscreen-doctor -j)
	scrn_n=$(kdotool getmouselocation | cut -d' ' -f 3 | cut -d':' -f 2)
	if [[ ! $scrn_n ]]; then
		err "Something went REALLY bad!"
		err "Bailing out."
		exit 1
	fi
	scrn_cur_mode_id=$(echo "$scrn_info" | jq ".outputs[$scrn_n].currentModeId")
	scrn_W=$(echo "$scrn_info" | jq ".outputs.[$scrn_n].modes[] | select(.id==$scrn_cur_mode_id).size.width")
	scrn_H=$(echo "$scrn_info" | jq ".outputs.[$scrn_n].modes[] | select(.id==$scrn_cur_mode_id).size.height")
	if [[ ! $scrn_W =~ [[:digit:]] || ! $scrn_H =~ [[:digit:]] ]]; then
		err "Screen width '$scrn_W' or screen height '$scrn_H' are not digits."
		err "Cannot proceed with this script. Bailing out..."
		exit 1
	fi
	MOUSE_CENTER_X=$((scrn_W / 4))
	MOUSE_CENTER_Y=$((scrn_H / 4))
	if [[ "$__ZS_DEBUG" ]]; then
		info "Debug/Troubleshooting output"
		info "Screen #: $scrn_n"
		info "Screen current mode id: $scrn_cur_mode_id"
		info "Screen WIDTH x HEIGHT determined: $scrn_W x $scrn_H"
		info "Calculated center point: X$MOUSE_CENTER_X / Y$MOUSE_CENTER_Y"
	fi
}
function zooms {
	determine_screen
	sanities
	if [[ ! -f "$temp_file" ]]; then
		touch "$temp_file"
		ydotool mousemove -x -16384 -y -16384 && ydotool mousemove -x "$MOUSE_CENTER_X" -y "$MOUSE_CENTER_Y"
		for x in $(seq "$ZOOM_IN_AMOUNT"); do
			qdbus org.kde.kglobalaccel /component/kwin invokeShortcut "view_zoom_in"
		done
	else
		rm "$temp_file"
		for x in $(seq "$ZOOM_OUT_AMOUNT"); do
			qdbus org.kde.kglobalaccel /component/kwin invokeShortcut "view_zoom_out"
		done
	fi
}
function dep_sanity {
	if [[ ! $__ZS_IHADEP ]]; then
		for dep in "jq" "kdotool" "qdbus" "ydotool" "kscreen-doctor"; do
			if [[ "$__ZS_DEBUG" ]]; then
				info "Testing '$dep' dependency for presence."
			fi
			if [[ ! $(command -v $dep) ]]; then
				err "Missing script dependency: '$dep'."
				err "Please install it from your distro repositories."
				err "Script will now exit."
				exit 1
			else
				if [[ "$dep" == "ydotool" ]]; then
					if [[ ! $(systemctl status --user ydotool.service | grep 'Active: active') ]]; then
						info "Service 'ydotool' was not running. The script will attempt to start it for you."
						if ! systemctl start --user ydotool.service; then
							err "Unable to start ydotool service! Script will now abort."
							err "Either start 'ydotool.service' manually or troubleshoot."
							exit 1
						fi
					fi
				fi
			fi
		done
	fi
}
function sanities {
	if [[ ! "$ZOOM_IN_AMOUNT" || ! "$ZOOM_OUT_AMOUNT" ]]; then
		err "No zoom in or zoom out amounts are set."
		err "This script will now exit."
		err "Consider running in debug to troubleshoot the issue."
		exit 1
	fi
	if [[ ! "$MOUSE_CENTER_X" || ! "$MOUSE_CENTER_Y" ]]; then
		err "Unable to determine center X and Y coordinates."
		err "This script will now exit."
		err "Consider running in debug to troubleshoot the issue."
		exit 1
	fi
}
while [ $# -gt 0 ]; do
	case "$1" in
		-n|--no-deps-sanity)
			__ZS_IHADEP=1
			shift
			;;
		-d|--debug)
			__ZS_DEBUG=1
			shift
			;;
		-z|--zoom)
			if [[ ! $2 ]]; then
				err "You need to specify zoom amount."
				exit 1
			fi
			ZOOM_IN_AMOUNT="$2"
			# As a precaution, always have zoom out to be (zoom in + 5)
			ZOOM_OUT_AMOUNT=$((ZOOM_IN_AMOUNT + 5))
			shift 2
			;;
		-s|--only-sanities)
			dep_sanity
			sanities
			exit 0
			;;
		-t|--determine)
			determine_screen
			dep_sanity
			sanities
			exit 0
			;;
		-o|--only-determine)
			determine_screen
			exit 0
			;;
 		*)
 			warn "Option '$x' is not valid."
 			shift
 			;;
	esac
done
dep_sanity
zooms
