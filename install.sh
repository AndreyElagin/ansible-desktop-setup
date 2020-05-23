#!/usr/bin/env bash

cp locale.sh /mnt/locale.sh
cp network.sh /mnt/network.sh

./common.sh vda # replace with actual disk name

cat << EOF | arch-chroot /mnt
./locale.sh
./network.sh enp1s0
EOF
