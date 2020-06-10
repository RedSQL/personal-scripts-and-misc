#!/bin/bash
export SUDO_ASKPASS=$HOME/askpass.sh
# Insert your path to your ramdisk directory and name respectively here.
PATH_TO_RAMDISK=""
RAMDISK_NAME=""
MBRAMAMOUNT=$(kdialog --inputbox "Enter the size your ramdisk should be. (i.e 2048m, 4096m, 8192m and etc. 2GB aka 2048m is entered by default.) Enter 0 for unmount." "2048m")
if [ $MBRAMAMOUNT -eq 0 ]
then
    kdialog --msgbox "Number supplied was 0. Unmounting ramdisk."
    sudo -A umount $PATH_TO_RAMDISK
else
    # I am well aware that cancelling input box above will cause this to execute. I'm just too lazy to implement the check. (Want to do that yourself? PRs are always welcome!) Nothing catastrophic happens if you cancel out, anyway.
    sudo -A mount -t tmpfs -o size=$MBRAMAMOUNT $RAMDISK_NAME $PATH_TO_RAMDISK
    kdialog --msgbox "Ramdisk should be mounted on ${PATH_TO_RAMDISK} with ${MBRAMAMOUNT} of storage space."
fi
