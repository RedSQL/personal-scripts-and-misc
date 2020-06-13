#!/bin/bash
export SUDO_ASKPASS=$HOME/askpass.sh
# Insert your path to your ramdisk directory and name respectively here.
PATH_TO_RAMDISK=
RAMDISK_NAME=
MBRAMAMOUNT=$(kdialog --inputbox "Enter the size your ramdisk should be. (i.e 2048m, 4096m, 8192m and etc. 2GB aka 2048m is entered by default.) Enter 0 for unmount." "2048m")
if [ $MBRAMAMOUNT -eq 0 ]
then
    kdialog --msgbox "Number supplied was 0. Unmounting ramdisk."
    sudo -A umount $PATH_TO_RAMDISK
else
    if [ ! $MBRAMAMOUNT ]
    then
        kdialog --msgbox "Nothing was entered. Quitting script."
        exit
    else
        sudo -A mount -t tmpfs -o size=$MBRAMAMOUNT $RAMDISK_NAME $PATH_TO_RAMDISK
        kdialog --msgbox "Ramdisk should be mounted on ${PATH_TO_RAMDISK} with ${MBRAMAMOUNT} of storage space."
    fi
fi
