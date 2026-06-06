# Bash scripts
Contains bash scripts I wrote for one reason or another. Most of these are obsolete and are of no use to me and I doubt it'd be for anyone else, but I'll leave them here for now for historical purposes.

Some notable scripts are:
* **mouse-center-zoom.sh** - Script for calculating center of your screen, moving your mouse to it and initiating a zoom in a KDE Plasma environment. Depends on ydotool, qdbus, jq, kscreen-doctor, systemd and (obviously) KDE Plasma Desktop Environment.
* **openwrt-st-theme.sh** - Script to ssh into the OpenWRT router, fetch current themes installed on your router and give you a menu to change themes via command line.
* **router-post-update-restore.sh** - Script to restore packages, local and remote after an update to OpenWRT firmware. This primarily for those who use 3rd party repositories, e.g [Fantastic Packages](https://github.com/fantastic-packages/packages)
* **wallbang.sh** - Script *chain* to change a wallpaper on KDE Plasma desktop to a random one that is defined in the script. Requires KDE Plasma 6, kscreen-doctor, qdbus and Python 3.
* [[**Obsolete**?]] **fix-emojis.sh** - Script to manually change font types on Linux to display emojis correctly. This was made ages ago for an ancient problem and might not even be required anymore.

The rest are either self explanatory, niche (but perhaps useful) or have outlived its usefulness for whatever reason.