#!/usr/bin/env bash
ROUTER_SSH="CHANGEME"
function set_theme() {
	if [[ -z "$1" ]]; then
		exit 1
	fi
	ssh "$ROUTER_SSH" "uci set luci.main.mediaurlbase=\$(uci get luci.themes.$1) && uci commit || exit 1"
}
case "$1" in
	"bootstrap" | "boot")
		set_theme BootstrapDark || exit 1
	;;
	"material" | "mat")
		set_theme Material || exit 1
	;;
	"openwrt" | "ow")
		set_theme OpenWrt || exit 1
	;;
	"openwrt2020" | "ow2")
		set_theme OpenWrt2020 || exit 1
	;;
	"argon" | "arg")
		set_theme Argon || exit 1
	;;
	*)
		echo "Theme $1 not in list."
		exit 1
	;;
esac
