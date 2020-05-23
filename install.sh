#!/usr/bin/env bash

cp locale.sh /mnt/locale.sh

./common.sh vda # replace with actual disk name

cat << EOF | arch-chroot /mnt
ls -l
./locale.sh
EOF
