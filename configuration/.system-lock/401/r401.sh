#!/bin/bash
# restrictive-off.sh - Restore default firewall to permissive mode

if [[ $EUID -ne 0 ]]; then
   echo "Requires LV13 Access (sudo $0)"
   exit 1
fi

echo "[*] Deactive Prinbow 401."

iptables -F
iptables -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

echo "[*] Prinbow 401 Deactivated."

