#!/usr/bin/env bash

# Before chroot

set -e

DISK="$1"

if [ -z "$DISK" ]
then
      echo "Disk name is required"
      exit 666;
else
      echo "Setup partitions for disk: $DISK"
fi

umount -q /mnt/boot && umount -q /mnt

(
echo o      # Create a new empty partition table
echo y      # Proceed

echo n      # Add a new EFI partition
echo 1      # Partition number
echo        # First sector (Accept default: 1)
echo +512M  # Last sector (Accept default: varies)
echo EF00   # Hex code or GUID

echo n      # Add a new ROOT partition
echo 2      # Partition number
echo        # First sector (Accept default: 1)
echo        # Last sector (Accept default: varies)
echo        # Hex code or GUID

echo p      # Verify changes
echo w      # Write changes
echo y      # Apply changes
) | sudo gdisk "/dev/$DISK"

echo "Format created partitions"

yes | mkfs.fat -F32 "/dev/${DISK}p1"
yes | mkfs.ext4 "/dev/${DISK}p2"

mount "/dev/${DISK}p2" /mnt && \
mkdir /mnt/boot && \
mount "/dev/${DISK}p1" /mnt/boot

echo "Read output carefully"
sleep 8

echo "Update system clock"

timedatectl set-ntp true

echo "Installing OS packages"

pacstrap /mnt base base-devel linux linux-firmware openssh dhcpcd grub efibootmgr \
git vim man-db man-pages networkmanager reflector python-passlib ansible amd-ucode 

echo "Filling fstab"

genfstab -U /mnt >> /mnt/etc/fstab

echo "Copy installation scripts to mounted partition"

cp locale_and_user.sh /mnt/opt && chmod +x /mnt/opt/locale_and_user.sh
cp network.sh /mnt/opt && chmod +x /mnt/opt/network.sh
cp bootloader.sh /mnt/opt && chmod +x /mnt/opt/bootloader.sh
