#!/usr/bin/env bash

# chroot

set -e

echo "Setting up timezone"

ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc

echo "Setting up locales"

mv /etc/locale.gen /etc/locale.gen.bak && \
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen && \
echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
cat /etc/locale.gen && \
cat /etc/locale.conf && \
locale-gen

localectl set-locale LANG=en_US.UTF-8

echo "Set root password"

passwd

echo "Elect mirrors"

reflector --verbose --latest 200 --number 5 --sort rate --save /etc/pacman.d/mirrorlist