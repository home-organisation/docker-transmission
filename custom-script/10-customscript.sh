#!/usr/bin/env bash
set -eo pipefail
[[ "${DEBUG}" == "true" ]] && set -x

echo "Configuring Transmission..."
sed -i '/blocklist-enabled/c\    "blocklist-enabled": true,' /config/settings.json
sed -i '/blocklist-url/c\    "blocklist-url": "https://mirror.codebucket.de/transmission/blocklist.p2p.gz",' /config/settings.json
sed -i '/dht-enabled/c\    "dht-enabled": false,' /config/settings.json
sed -i '/pex-enabled/c\    "pex-enabled": false,' /config/settings.json
sed -i '/port-forwarding-enabled/c\    "port-forwarding-enabled": false,' /config/settings.json
sed -i '/download-dir/c\    "download-dir": "/downloads/",' /config/settings.json
sed -i '/incomplete-dir-enabled/c\    "incomplete-dir-enabled": false,' /config/settings.json

echo "Create films and tvshows directory..."
mkdir -p "/downloads/${DOWNLOAD_FILMCATEGORY}"
chown abc:users "/downloads/${DOWNLOAD_FILMCATEGORY}"
mkdir -p "/downloads/${DOWNLOAD_TVCATEGORY}"
chown abc:users "/downloads/${DOWNLOAD_TVCATEGORY}"

echo "Set resume and torrent directory right"
mkdir -p "/config/torrents"
chown abc:users "/config/torrents"
mkdir -p "/config/resume"
chown abc:users "/config/resume"

echo "resolv dns resolution issue"
ip=$(nslookup connect.maxp2p.org 192.168.1.21 | grep Address | awk '{ print $2 }' | sed -n 2p)
echo "${ip} connect.maxp2p.org" >> /etc/hosts