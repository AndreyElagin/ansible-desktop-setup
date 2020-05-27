#!/usr/bin/env bash

# After login

pacman -S reflector

echo "Elect nearest and quick mirrors"

reflector --verbose --latest 200 --number 5 --sort rate --save /etc/pacman.d/mirrorlist

echo "Create user"

useradd -m -g users -G wheel,storage,power,docker,autologin,audio -s /bin/bash daddyingrave
passwd daddyingrave

echo "Install YAY"

mkdir /opt/sources && \
cd /opt/sources && \
git clone https://aur.archlinux.org/yay.git && \
cd yay && \
makepkg -si && \
yay - editmenu - nodiffmenu - save && \
rm -rf /opt/sources

echo "Optimize packages compilation"

grep "COMPRESSXZ=(xz" /etc/makepkg.conf && \
grep "#MAKEFLAGS=\"-j" /etc/makepkg.conf && \
sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T 16 -z -)/g' /etc/makepkg.conf && \
sudo sed -i 's/#MAKEFLAGS=”-j2"/MAKEFLAGS=”-j9"/g' /etc/makepkg.conf
grep "COMPRESSXZ=(xz" /etc/makepkg.conf && \
grep "#MAKEFLAGS=\"-j" /etc/makepkg.conf
