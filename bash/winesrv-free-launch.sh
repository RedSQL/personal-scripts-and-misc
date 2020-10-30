#!/usr/bin/bash
if pgrep -x "wineserver" >/dev/null; then
    if kdialog --title "Wineserver detected!" --yesno "You have winesrv running! Do you want to kill it?"; then
        kdesu sudo killall wineserver
    fi
else
    echo "Wineserver is not running!"
    # Your custom Wine launch code
fi
