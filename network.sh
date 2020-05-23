#!/usr/bin/env bash

ADAPTER="$1"

echo "Setup hostname"

echo daddyingrave >> /etc/hostname

echo "Setup /etc/hosts"

{
  echo "127.0.0.1	localhost";
  echo "::1	localhost";
  echo "127.0.1.1	daddyingrave.localdomain daddyingrave";
} >> /etc/hosts


cat /etc/hosts

echo "enable sshd and dhcpcd services"

systemctl enable sshd.service && systemctl enable dhcpcd

echo "Setup systemd network"

cat << EOF >> /etc/systemd/network/20-wired.network
[Match]
Name=$ADAPTER

[Network]
DHCP=ipv4
EOF

echo "Setup DNS"

grep "DNS=" /etc/systemd/resolved.conf && \
sudo sed -i -e "s/#DNS=/DNS=1.1.1.1 1.0.0.1/g" /etc/systemd/resolved.conf && \
grep "DNS=" /etc/systemd/resolved.conf

cat /etc/systemd/resolved.conf

echo "Enable network daemons"

systemctl enable systemd-networkd && \
systemctl enable systemd-resolved && \
systemctl stop dhcpcd && \
systemctl disable dhcpcd && \
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf && \
ls -la /etc/resolv.conf && \
resolvectl status

