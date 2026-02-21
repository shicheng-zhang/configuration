#!/bin/bash
# isolation-off.sh - Disable isolation mode and restore normal networking

# Require root
if [[ $EUID -ne 0 ]]; then
   echo "Root LV13 Auth Required (sudo $0)"
   exit 1
fi

echo "[*] Restoring System."

### 1. Reset firewall ###
iptables -F
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

### 2. Bring interfaces back up ###
for iface in $(ls /sys/class/net/ | grep -v lo); do
    ip link set "$iface" up
    echo "[*] Interface $iface up"
done

### 3. Unmask services ###
systemctl unmask NetworkManager.service
systemctl unmask systemd-networkd.service
systemctl unmask ssh.service
systemctl unmask wpa_supplicant.service

### 4. Restart networking ###
systemctl restart NetworkManager || systemctl restart systemd-networkd

rfkill unblock all

echo "[*] Danang 666 Seal Unlocked"

