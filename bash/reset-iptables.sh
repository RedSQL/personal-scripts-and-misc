#!/bin/bash
# I beg all of you, please stop messing with my iptables...
export SUDO_ASKPASS=$HOME/askpass.sh
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -F
kdialog --msgbox "Done! Hopefully it's reset now."
