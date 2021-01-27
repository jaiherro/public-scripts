#!/bin/bash

# Proxmox init script usage: wget -O - https://example.com/proxmox.sh | bash

# Set for no-subscription repo
rm /etc/apt/sources.list.d/pve-enterprise.list
echo "deb http://download.proxmox.com/debian buster pve-no-subscription" >> /etc/apt/sources.list

# Remove subscription banner on login
sed -i.backup -z "s/res === null || res === undefined || \!res || res\n\t\t\t.data.status \!== 'Active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service

# Update all packages
apt update -qy
apt-get install aria2 curl apcupsd htop iotop smartmontools ifupdown2 -qy
apt dist-upgrade -qy
reboot
