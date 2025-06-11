#!/bin/bash

lb config \
  --distribution bookworm \
  --archive-areas "main contrib non-free non-free-firmware" \
  --apt-recommends true \
  --backports true \
  --security true \
  --updates true \
  --binary-images iso-hybrid \
  --bootappend-live "boot=live components" \
  --bootloaders "syslinux grub-efi" \
  --checksums sha512 \
  --color \
  --compression xz \
  --debian-installer cdrom \
  --debian-installer-gui false \
  --interactive shell \
  --iso-publisher "Dima <dmytroperets@gmail.com>" \
  --system live \
  --verbose \
  --firmware-binary true \
  --firmware-chroot true
