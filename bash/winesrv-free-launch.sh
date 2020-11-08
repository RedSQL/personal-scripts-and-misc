#!/usr/bin/bash
# Constants

# Workaround because I cannot detect wine application with pgrep :/
PROC_NAME=""
WINE_EXECUTABLE=$(ps -A | grep $PROC_NAME | awk '{print $4}')

# Options

# Enables Konsole for log output
with_console=1

# Custom Exports
export WINEESYNC=1
export WINEFSYNC=1

# Function definition

# Pass any 1st argument in to re-detect wineserver and application
launch_wine() {
    if [ $1 ]; then
        if pgrep -x "wineserver" >/dev/null; then
            if [ -z "$WINE_EXECUTABLE" ]; then
                kdesu sudo killall wineserver
                kdesu sudo killall $PROC_NAME
                sleep 5
                launch_wine
            else
                launch_wine
            fi
        fi
    fi
    # Your wine launch code below!
    if [ $with_console == 1 ]; then
        # konsole -e YOUR WINE LAUNCH CODE HERE!
    else
        # YOUR WINE LAUNCH CODE HERE!
    fi
    
}

# Main launch
if pgrep -x "wineserver" >/dev/null; then
    # Seeing if wineserver is still active after a while
    sleep 7
    if pgrep -x "wineserver" >/dev/null; then
        if kdialog --title "Wineserver detected!" --yesno "You have wineserver running! Do you want to kill it?"; then
            kdesu sudo killall wineserver
            sleep 3
            launch_wine 1
        fi
    else
        launch_wine 1
    fi
else
    echo "Wineserver is not running! Proceeding."
    launch_wine
fi
