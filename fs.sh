#!/usr/bin/env bash

DISK="vda" # replace with actual disk name

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
echo Y      # Apply changes
) | sudo gdisk "/dev/$DISK"

echo "Format created partitions"

yes | mkfs.fat -F32 "/dev/${DISK}1"
yes | mkfs.ext4 "/dev/${DISK}2"

mount "/dev/${DISK}2" /mnt && \
mkdir /mnt/boot && \
mount "/dev/${DISK}1" /mnt/boot