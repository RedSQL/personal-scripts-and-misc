#!/usr/bin/bash
# dirty autoclicker hack
QUERY_STATE=
KEY_ID=
while true; do
	state=`xinput --query-state $QUERY_STATE | grep -o "key\[$KEY_ID\]=down"`
	if [ ! -z "$state" ]; then
		xdotool click 3
	fi
done
