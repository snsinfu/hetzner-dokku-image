#!/bin/sh -eu

PIF=eth0

# Install firewall scripts
sed "s/%PIF%/${PIF}/" /tmp/assets/ipv4_firewall.sh.in > /etc/ipv4_firewall.sh
sed "s/%PIF%/${PIF}/" /tmp/assets/ipv6_firewall.sh.in > /etc/ipv6_firewall.sh

chmod a+x /etc/ipv4_firewall.sh
chmod a+x /etc/ipv6_firewall.sh

# Enable firewall services
cp /tmp/assets/ipv4_firewall.service /etc/systemd/system/
cp /tmp/assets/ipv6_firewall.service /etc/systemd/system/

systemctl enable ipv4_firewall
systemctl enable ipv6_firewall
