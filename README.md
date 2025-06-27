# My Linux Dotfiles 👑

This repository contains my personal NixOS and Home-Manager configurations, managed centrally using [Nix Flake](https://nixos.wiki/wiki/Flakes). It provides modular, version-controlled management for system, desktop, application, and user-level settings.

---

## Directory Structure

- `flake.nix`: Flake entry point, defines NixOS and Home-Manager inputs and outputs.
- `hosts/`: Per-host NixOS configurations (e.g., `vivo`).
- `system/`: System-level NixOS modules (hardware, network, services, etc.).
- `home/`: Home-Manager user-level modules and settings.
- `pkgs/`: Custom Nix packages or scripts (e.g., the `switch` tool).
- `dots/`: Application configs (rofi, kitty, wezterm, waybar, etc.).
- `scripts/`: Helper scripts for installation and removal.



## Installation Guide

```bash
sudo -i

git clone https://github.com/LiamStanDev/nix-dots.git

# 1. Get nix disko config and edit it
cp nix-dots/hosts/<your-machine>/disko.nix /tmp/disko.nix
vim /tmp/disko.nix

# 2. Partitioning
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/disko.nix

# 3. Check partition
mount | grep /mnt # verify auto mount. (important)

# 4. Editing system
nixos-generate-config --no-filesystems --root /mnt
cp /tmp/disko.nix /mnt/etc/nixos/disko.nix
vim /mnt/etc/nixos/configuration.nix

```
```
```
```
```

`/etc/nixos/configuration.nix`

```nix
imports =
 [
   ./hardware-configuration.nix
   "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
   ./disko.nix
 ];

boot.loader.grub.enable = true;
boot.loader.grub.efiSupport = true;
boot.loader.grub.efiInstallAsRemovable = true;

```


```bash
# 3. Install NixOS
nixos-install

# 4. Copy hardware-configuration.nix file
nixos-enter --root /mnt # enter your brand-new os
passwd <user>  # change user password
cd /home/<user>
git clone https://github.com/LiamStanDev/nix-dots.git
cp /etc/nixos/hardware-configuration.nix /home/<user>/nix-dots/hosts/<host>
exit 

# 4. Reboot
reboot
```

> Note: Use label instead of UUID for disko setup. label is way easier


nix --experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' -- --write-efi-boot-entries --flake '/tmp/config/etc/nixos#mymachine' --disk main /dev/vda
