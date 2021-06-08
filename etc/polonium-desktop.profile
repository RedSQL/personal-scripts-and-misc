# Firejail profile for polonium-desktop
# Description: Matrix/Element fork with custom emote support
# This file is overwritten after every install/update
# Persistent local customizations
include polonium-desktop.local
# Persistent global definitions
# added by included profile
#include globals.local

ignore dbus-user none

noblacklist ${HOME}/.config/Polonium

mkdir ${HOME}/.config/Polonium
whitelist ${HOME}/.config/Polonium
whitelist /opt/Polonium
whitelist /usr/share/webapps/polonium

private-opt Polonium

dbus-user filter
dbus-user.talk org.freedesktop.secrets

# Redirect
include riot-desktop.profile
