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

#echo daddyingrave >> /etc/hostname
#14. pacman -S dhcpcd
#15. systemctl enable sshd.service && systemctl enable dhcpcd
#16. echo -e '127.0.0.1\tlocalhost\n::1\tlocalhost\n127.0.1.1\tdaddyingrave.localdomain\tdaddyingrave' /etc/hosts
#
#    ```
#    /etc/systemd/network/20-wired.network[Match]
#    Name=enp3s0f0[Network]
#    DHCP=ipv4
#    ```
#
#    ```
#    grep “DNS=” /etc/systemd/resolved.conf && \
#    sudo sed -i -e ‘s/#DNS=/DNS=1.1.1.1 1.0.0.1/g’ /etc/systemd/resolved.conf && \
#    grep “DNS=” /etc/systemd/resolved.conf
#
#    cat /etc/systemd/resolved.conf
#
#    [Resolve]
#    DNS=1.1.1.1 1.0.0.1
#    ```
#
#    ```
#    systemctl enable systemd-networkd && \
#    systemctl enable systemd-resolved && \
#    systemctl start systemd-networkd && \
#    systemctl start systemd-resolved && \
#    systemctl stop dhcpcd && \
#    systemctl disable dhcpcd && \
#    ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf && \
#    ls -la /etc/resolv.conf && \
#    resolvectl status
#    ```
#
#17. useradd -m -g users -G wheel,storage,power,docker,audio -s /bin/bash daddyingrave && passwd daddyingrave
#18. visudo → uncomment %wheel ALL=(ALL) NOPASSWD: ALL
#19. pacman install -S grub
#20. grub-install --target=i386-pc /dev/??? (without num)
#21. grub-mkconfig -o /boot/grub/grub.cfg
#22.
#
#```
#mkdir sources && \
#cd sources && \
#git clone https://aur.archlinux.org/yay.git && \
#cd yay && \
#makepkg -si && \
#yay - editmenu - nodiffmenu - save
#```
#
#```
#grep “COMPRESSXZ=(xz” /etc/makepkg.conf && \
#grep “#MAKEFLAGS=\”-j” /etc/makepkg.conf && \
#sudo sed -i ‘s/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T 16 -z -)/g’ /etc/makepkg.conf && \
#sudo sed -i ‘s/#MAKEFLAGS=”-j2"/MAKEFLAGS=”-j9"/g’ /etc/makepkg.conf
#grep “COMPRESSXZ=(xz” /etc/makepkg.conf && \
#grep “#MAKEFLAGS=\”-j” /etc/makepkg.conf
#```
