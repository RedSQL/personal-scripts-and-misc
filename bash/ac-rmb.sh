#!/usr/bin/bash
# dirty autoclicker hack
# FYI: This will NOT work on Wayland. This will only work on native X11 session or Xwayland windows.
# Currently, Wayland does not have any way to capture keyboard keys through any API.
QUERY_STATE=
KEY_ID=
while true; do
	state=`xinput --query-state $QUERY_STATE | grep -o "key\[$KEY_ID\]=down"`
	if [ ! -z "$state" ]; then
		xdotool click 3
	fi
done
