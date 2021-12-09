#!/usr/bin/env bash
# i tested this script to the best of my abilities but if there are still issues lmk :p
fix_font() {
	if [ ! -d "$HOME/.config/fontconfig" ]; then
		mkdir $HOME/.config/fontconfig
	fi
	cd $HOME/.config/fontconfig/ || exit
	if [ -e "fonts.conf" ]; then
		mv -b ~/.config/fontconfig/fonts.conf ~/.config/fontconfig/fonts.conf.backup || exit
		echo -e "\e[1;32mYou already had fonts.conf in your fontconfig folder. I renamed the previous file to 'fonts.conf.backup' in case this script messes up your fonts.conf.\e[0m"
	fi
	wget https://raw.githubusercontent.com/RedSQL/personal-scripts-and-misc/master/bash/assets/fonts.conf
	# just to be sure
	if [ -e "fonts.conf" ]; then
		font_hash=$(sha256sum 'fonts.conf' | awk '{ print $1 }')
		if [ "$font_hash" == "63633ddd9391a5e06733d9ddee7916d846370118638981058092766b41" ] || [ "$font_hash" == "175c5f934404234d065cbd7bf81f4a23a9c9b3bee0795e54ef2689d920f68559" ]; then
			echo -e "\e[1;32mDone. Restart your applications, relog or restart your system to (hopefully) see the changes.\e[0m"
		fi
	fi
}
distro_check() {
	pacman_exists=$(command -v pacman)
	if [ -n "$pacman_exists" ]; then
		echo -e "\e[1;34mEnter the password to execute the package manager which will install the emoji font package.\e[0m"
		sudo pacman -S noto-fonts-emoji
		fix_font
	else
		echo -e "\e[1;31mYou don't appear to be running a pacman-based distro. Please install 'noto-fonts-emoji' (or however that package is named within your distros repos) with your package manager manually. After that, run this script with '--no-distrocheck'.\e[0m"
		exit
	fi
}
if [[ "$@" == "--no-distrocheck" ]]; then
	fix_font
	exit
fi
distro_check
