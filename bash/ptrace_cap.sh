#!/bin/bash
export SUDO_ASKPASS=$HOME/askpass.sh
CAP_CHOICE=$(kdialog --combobox "Do you want to set or reset the ptrace cap?" "Set" "Reset")
if [ $CAP_CHOICE == "Set" ]
then
    kdialog --msgbox "Setting ptrace cap to eip..."
    # I needed to do that to wine. You can add more or change this to anything you'd like for any needs you might need.
    sudo -A setcap cap_sys_ptrace=eip /usr/bin/wineserver
    sudo -A setcap cap_sys_ptrace=eip /usr/bin/wine-preloader
    exit
else
    kdialog --msgbox "Resetting ptrace cap..."
    sudo -A setcap -r /usr/bin/wineserver
    sudo -A setcap -r /usr/bin/wine-preloader
    exit
fi
