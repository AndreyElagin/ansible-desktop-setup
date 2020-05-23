

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
#grep "COMPRESSXZ=(xz" /etc/makepkg.conf && \
#grep "#MAKEFLAGS=\"-j" /etc/makepkg.conf && \
#sudo sed -i ‘s/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T 16 -z -)/g’ /etc/makepkg.conf && \
#sudo sed -i ‘s/#MAKEFLAGS="-j2"/MAKEFLAGS="-j9"/g’ /etc/makepkg.conf
#grep "COMPRESSXZ=(xz" /etc/makepkg.conf && \
#grep "#MAKEFLAGS=\"-j" /etc/makepkg.conf
#```
