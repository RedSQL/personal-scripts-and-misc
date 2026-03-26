#!/usr/bin/env bash
ROUTER_SSH="CHANGEME"
if [[ ! $(command -v dialog) ]]; then
	echo "Missing dependency: dialog"
	exit 1
fi
function set_theme() {
	if [[ -z "$1" ]]; then
		exit 1
	fi
	ssh "$ROUTER_SSH" "uci set luci.main.mediaurlbase=\$(uci get $1) && uci commit || exit 1"
}
function get_themes() {
	if [[ -f "/tmp/ost-luci-themes.txt" ]]; then
		RT_THEMES=$(</tmp/ost-luci-themes.txt)
		if [[ ! $(echo "$RT_THEMES" == *"luci.themes.Bootstrap"*) ]]; then
			# I find it hard to believe that there won't be boostrap theme installed on an openwrt router. Let's not consider cache in this case.
			echo "Warn: no bootstrap theme in ost-luci-themes, cache discarded."
			RT_THEMES=$(ssh "$ROUTER_SSH" "uci show luci.themes || exit 1" | awk -F= '/^luci\.themes\./{print $1}')
			echo "$RT_THEMES" > /tmp/ost-luci-themes.txt
		fi
	else
		RT_THEMES=$(ssh "$ROUTER_SSH" "uci show luci.themes || exit 1" | awk -F= '/^luci\.themes\./{print $1}')
		echo "$RT_THEMES" > /tmp/ost-luci-themes.txt
	fi
}
get_themes || exit 1
if [[ -n "$RT_THEMES" ]]; then
	THEME_CHOICE=$(dialog --keep-tite --stdout --menu pick 16 65 1 $(echo "$RT_THEMES" | awk '{ printf $1; printf " "; printf $1; printf " " }'))
	if [[ -n "$THEME_CHOICE" ]]; then
		set_theme "$THEME_CHOICE" || exit 1
	fi
fi
