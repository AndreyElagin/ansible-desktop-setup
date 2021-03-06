#!/usr/bin/env bash

# In chroot

set -e

ADAPTER="$1"

if [ -z "$ADAPTER" ]
then
      echo "Interface name is required"
      exit 666;
else
      echo "Setup network for interface: $ADAPTER"
fi

echo "Setup hostname"

hostnamectl set-hostname daddyingrave-arch

echo "Setup /etc/hosts"

{
  echo "127.0.0.1 localhost";
  echo "::1   localhost";
  echo "127.0.1.1	daddyingrave-arch.localdomain daddyingrave-arch";
} >> /etc/hosts


cat /etc/hosts

echo "enable sshd and dhcpcd services"

systemctl enable sshd.service &&
systemctl enable NetworkManager

echo "Setup network manager"

cat << EOF >> /etc/NetworkManager/conf.d/dns-servers.conf
[global-dns-domain-*]
servers=1.1.1.1,1.0.0.1
EOF
