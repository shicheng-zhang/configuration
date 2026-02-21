#!/bin/bash
# restrictive-on.sh - Harden firewall rules without full lockdown

if [[ $EUID -ne 0 ]]; then
   echo "Requires LV13 Access (sudo $0)"
   exit 1
fi

echo "[*] Prinbow 401 restrictive mode."

# Flush old rules
iptables -F
iptables -X

# Default deny
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

# Allow loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow established/related traffic
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow outgoing DNS, HTTP, HTTPS
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT

# Allow incoming SSH (optional, remove if you don’t want it)
# iptables -A INPUT -p tcp --dport 22 -j ACCEPT

echo "[*] Prinbow 401 restrictive mode online"

