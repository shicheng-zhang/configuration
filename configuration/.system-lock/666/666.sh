#!/bin/bash
# isolation-on.sh - Enable full isolation mode

# Require root
if [[ $EUID -ne 0 ]]; then
   echo "Root LV13 Access Required (sudo $0)"
   exit 1
fi

echo "[*] Mode: 666"

### 1. Cut all external network connections ###
# Drop all traffic
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
iptables -F

# Allow loopback only
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Bring down all non-loopback interfaces
for iface in $(ls /sys/class/net/ | grep -v lo); do
    ip link set "$iface" down
    echo "[*] Interface $iface down"
done

echo "[*] External Connections Cut"

### 2. Lock systemd service activations ###
systemctl mask --now NetworkManager.service
systemctl mask --now systemd-networkd.service
systemctl mask --now ssh.service
systemctl mask --now wpa_supplicant.service
rfkill block all

echo "[*] Run Root -666 to restart system functionality."
echo "[*] Danang 666 Class firewall online."

