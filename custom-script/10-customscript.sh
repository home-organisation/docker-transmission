#!/usr/bin/env bash
set -eo pipefail
[[ "${DEBUG}" == "true" ]] && set -x

# Default values
if [ -z "${BASEURL}" ]; then BASEURL="/transmission/"; fi

# Map old variables to new ones for compatibility
if [ -n "${DOWNLOAD_FILMCATEGORY}" ]; then FILMCATEGORY="${DOWNLOAD_FILMCATEGORY}"; fi
if [ -n "${DOWNLOAD_TVCATEGORY}" ]; then TVCATEGORY="${DOWNLOAD_TVCATEGORY}"; fi
if [ -n "${DOWNLOAD_GAMECATEGORY}" ]; then GAMECATEGORY="${DOWNLOAD_GAMECATEGORY}"; fi

# Set configuration values
echo "Configuring Transmission..."
sed -i '/blocklist-enabled/c\    "blocklist-enabled": true,' /config/settings.json
sed -i '/blocklist-url/c\    "blocklist-url": "https://mirror.codebucket.de/transmission/blocklist.p2p.gz",' /config/settings.json
sed -i '/dht-enabled/c\    "dht-enabled": false,' /config/settings.json
sed -i '/pex-enabled/c\    "pex-enabled": false,' /config/settings.json
sed -i '/port-forwarding-enabled/c\    "port-forwarding-enabled": false,' /config/settings.json
sed -i '/download-dir/c\    "download-dir": "/downloads/",' /config/settings.json
sed -i '/incomplete-dir-enabled/c\    "incomplete-dir-enabled": false,' /config/settings.json
sed -i '/rpc-url/c\    "rpc-url": "'"${BASEURL}"'",' /config/settings.json

# Create category directories
if [ -n "${FILMCATEGORY}" ]; then
  echo "Create films directory..."
  mkdir -p "/downloads/${FILMCATEGORY}"
  chown abc:users "/downloads/${FILMCATEGORY}"
fi

if [ -n "${TVCATEGORY}" ]; then
  echo "Create tv directory..."
  mkdir -p "/downloads/${TVCATEGORY}"
  chown abc:users "/downloads/${TVCATEGORY}"
fi

if [ -n "${GAMECATEGORY}" ]; then
  echo "Create gaming directory..."
  mkdir -p "/downloads/${GAMECATEGORY}"
  chown abc:users "/downloads/${GAMECATEGORY}"
fi

# Create configuration directory
echo "Set resume and torrent directory right"
mkdir -p "/config/torrents"
chown abc:users "/config/torrents"
mkdir -p "/config/resume"
chown abc:users "/config/resume"

# Debug openshift dns resolution
sleep 5
ip=$(nslookup connect.maxp2p.org 192.168.1.21 | grep Address | awk '{ print $2 }' | sed -n 2p)
echo "Adding connect.maxp2p.org to /etc/hosts with IP ${ip}"
echo "${ip}    connect.maxp2p.org" >> /etc/hosts
