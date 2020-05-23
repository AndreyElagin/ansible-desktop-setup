#!/usr/bin/env bash

echo "Setup hostname"

echo daddyingrave >> /etc/hostname

echo "Setup /etc/hosts"

echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1	localhost" >> /etc/hosts
echo "127.0.1.1	daddyingrave.localdomain daddyingrave" >> /etc/hosts 

cat /etc/hosts

echo "enable sshd and dhcpcd services"

systemctl enable sshd.service && systemctl enable dhcpcd

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
