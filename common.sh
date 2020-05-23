#!/usr/bin/env bash

echo "Setup date/time"

timedatectl set-ntp true

echo "Installing OS packages"

pacstrap /mnt base base-devel linux linux-firmware openssh dhcpcd grub

echo "Filling fstab"

genfstab -U /mnt >> /mnt/etc/fstab

echo "Setting up timezon"

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

echo LANG=en_US.UTF-8 >> /etc/locale.conf
