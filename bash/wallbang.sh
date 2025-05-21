#!/usr/bin/env bash
# shellcheck disable=SC2164

# Wallbang - a *really* bad script chain to change KDE Plasma 6 wallpaper to a random pre-selected one on launch
# Requires PowerSnail's Python script to change the wallpaper[1], which requires typer ("python-typer" in Arch Linux repositories[2])
# [1] - https://powersnail.com/2023/set-plasma-wallpaper/#parameterize
# [2] - https://archlinux.org/packages/extra/any/python-typer/
# Also requires: jq, kscreen-doctor, qdbus, python 3 (obviously)

# CUSTOMIZATION
# -----
# Set to a path where python script is stored
WD_PATH="$HOME/Scripts"
# Set to a filename that the script will be using
PYTHON_SCRIPT_NAME="snail-plasma-wp.py"
# Change to all the wallpapers you wish to be applied randomly
safe_wp_array=("/usr/share/wallpapers/Flow/contents/images_dark/5120x2880.jpg"
			   "/usr/share/wallpapers/ScarletTree/contents/images_dark/5120x2880.png"
			   "/usr/share/wallpapers/Shell/contents/images/5120x2880.jpg"
			   "/usr/share/wallpapers/Opal/contents/images/3840x2160.png"
			   "/usr/share/wallpapers/Nexus/contents/images_dark/5120x2880.png")
# -----

if [[ ! -d "$WD_PATH" ]]; then
	echo "Error: path '$WD_PATH' not found." | logger -s -t "Wallbang" -p user.error
	popd
	exit 1
fi
pushd "$WD_PATH" || exit 1
if [[ ! -f "$PYTHON_SCRIPT_NAME" ]]; then
	echo "Error: script '$PYTHON_SCRIPT_NAME' not found in working directory." | logger -s -t "Wallbang" -p user.error
	popd
	exit 1
fi
get_setup_info() {
	local match_cur_wp
	NUM_OF_DISPLAYS=$(kscreen-doctor -j | jq '.outputs | length')
	for x in $(seq "$NUM_OF_DISPLAYS"); do
		idx_zp=$((x-1))
		match_cur_wp=$(qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.wallpaper $idx_zp | rg 'Image:' | head -n1 | cut -c8-)
		if [[ -n "$match_cur_wp" ]]; then
			for i in "${!safe_wp_array[@]}"; do
				if [[ ${safe_wp_array[i]} = *"$match_cur_wp"* ]]; then
					unset 'safe_wp_array[i]'
					for y in "${!safe_wp_array[@]}"; do
						tmp_array+=( "${safe_wp_array[y]}" )
					done
					safe_wp_array=("${tmp_array[@]}")
					unset tmp_array
				fi
			done
			wallbang_rng "$idx_zp"
			if [[ $? -ge 1 ]]; then
				return 1
			fi
		fi
	done
	popd || exit 1
}
function wallbang_rng() {
	local sg_iterate_count
	sg_iterate_count=0
	wp_rand=${safe_wp_array[RANDOM%${#safe_wp_array[@]}]}
	while [[ ! -f "$wp_rand" ]]; do
		wp_rand=${safe_wp_array[RANDOM%${#safe_wp_array[@]}]}
		((sg_iterate_count++))
		if [[ $sg_iterate_count -ge 256 ]]; then
			echo "Script looped for 256 times but could not find a wallpaper file once." | logger -s -t "Wallbang" -p user.error
			echo "Either you are really unlucky, or you do not have any wallpapers in the list selected," | logger -s -t "Wallbang" -p user.error
			echo "or you have more missing files than existing and got unlucky." | logger -s -t "Wallbang" -p user.error
			return 2
		fi
	done
	if [[ -z "$1" ]]; then
		if [[ -f "$wp_rand" ]]; then
			/usr/bin/env python3 "$PYTHON_SCRIPT_NAME" all "$wp_rand"
			return 0
		fi
	else
		if [[ -f "$wp_rand" ]]; then
			/usr/bin/env python3 "$PYTHON_SCRIPT_NAME" one "$1" "$wp_rand"
			return 0
		fi
	fi
}
get_setup_info
