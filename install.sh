#!/usr/bin/env bash

./common.sh vda # replace with actual disk name

cat << EOF | arch-chroot /mnt
./locale.sh
EOF