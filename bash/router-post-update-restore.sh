#!/usr/bin/env bash
# Script to restore self uploaded packages and custom repo packages (and nlbwmon db) after openwrt upgrade with configuration loss.
# Set this to either ssh alias for your router or username@ip of your router.
ROUTER_SSH="CHANGEME"
# Set this to your download folder (or wherever you save downloaded .apk/.tar.gz files)
DOWNLOADS_FOLDER="CHANGEME"
# NOTE: do not include version numbers unless you want a specific version copied.
# This will copy .apks that match from DOWNLOADS_FOLDER.
PKG_MATCH=(
	'luci-app-CHANGEME'
	'luci-theme-CHANGEMETOO'
)
# This will manually install packages listed here. Will always run after PKG_MATCH installs in case a keyring/package feed is included above.
RESTORE_PACKAGES=(
	'luci-app-CHANGEME'
	'luci-theme-CHANGEMETOO'
)
# Leave blank if you do not wish to restore nlbwmon db. Otherwise put anything in.
BACKUP_NLBWMON="1"
# Create a file called openwrt-restore-predefined.sh with all the values above predefined if you wish to not change the configuration in the script.
# All file contents need to be are:
# ROUTER_SSH="YOUR SSH ENDPOINT"
# DOWNLOADS_FOLDER="YOUR DOWNLOAD FOLDER PATH"
# PKG_MATCH=("ARRAY" "OF" "PACKAGES" "TO" "FIND" "IN" "DOWNLOAD" "FOLDER")
# RESTORE_PACKAGES=("NAMES" "OF" "REMOTE" "PACKAGES" "TO" "INSTALL" "AFTER" "PKG_MATCH" "INSTALLS")
# BACKUP_NLBWMON="NOTHING OR SOMETHING"
if [[ -f "openwrt-restore-predefined" ]]; then
	source openwrt-restore-predefined || exit 1
fi
if [[ ! -d "/tmp/openwrt-restore" ]]; then
	mkdir /tmp/openwrt-restore || exit 1
fi
pushd /tmp/openwrt-restore || exit 1
if [[ ! -d "packages" ]]; then
	mkdir packages || exit 1
	echo "Script will copy latest .apk packages defined in the script to be uploaded and installed on the router to $(pwd)/packages"
fi
for x in "${PKG_MATCH[@]}"; do
	cp $(/usr/bin/ls -1t "$DOWNLOADS_FOLDER/$x"*".apk" | head -n1) packages/
done
# NOTE: This will only copy latest archive that is named like this.
if [[ -n "$BACKUP_NLBWMON" ]]; then
	cp $(/usr/bin/ls -1t "$DOWNLOADS_FOLDER/nlbwmon-backup-"*".tar.gz"| head -n1) .
fi
ssh "$ROUTER_SSH" "mkdir /tmp/openwrt-restore"
scp -r "packages/"*".apk" "$ROUTER_SSH":/tmp/openwrt-restore/
scp $(/usr/bin/ls -1t "nlbwmon-backup-"*".tar.gz"| head -n1) "$ROUTER_SSH":/tmp/nlbw-restore.tar.gz
ssh "$ROUTER_SSH" "apk add --allow-untrusted /tmp/openwrt-restore/*.apk"
ssh "$ROUTER_SSH" "apk add ${RESTORE_PACKAGES[*]}"
ssh "$ROUTER_SSH" "/usr/libexec/nlbwmon-action restore"
popd || exit 0
exit 0
