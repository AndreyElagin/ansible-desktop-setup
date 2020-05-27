#!/usr/bin/env bash

DISK="$1"

umount -q /mnt/boot && umount -q /mnt

echo "Create new partitions on $DISK"

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

yes | mkfs.fat -F32 "/dev/${DISK}1"
yes | mkfs.ext4 "/dev/${DISK}2"

mount "/dev/${DISK}2" /mnt && \
mkdir /mnt/boot && \
mount "/dev/${DISK}1" /mnt/boot

echo "Update system clock"

timedatectl set-ntp true

echo "Installing OS packages"

pacstrap /mnt base base-devel linux linux-firmware openssh dhcpcd grub git vim man-db man-pages networkmanager

echo "Filling fstab"

genfstab -U /mnt >> /mnt/etc/fstab

cp locale.sh /mnt/opt
cp network.sh /mnt/opt
