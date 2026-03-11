---
Title: Booting from tftp
Date: 2026-03-09 09:14
Modified: 2026-03-09 09:14
Category: system
Tags: tftp,boot,dhcp
Slug: booting-from-tftp
Authors: Alejandro Visiedo
Summary: How to get a Linux booting from tftp
Header_Cover:
---
# Booting from tftp

This is the content of my super blog post.

## Preparing server side

- Install required packages:
  ```sh
  run0 dnf install -y dnsmasq shim-x64 shim-arm64 grub2-efi-x64 grib2-efi-arm64
  ```
- Configure dnsmasw
  ```sh
