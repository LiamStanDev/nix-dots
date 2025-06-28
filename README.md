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

# Options: install vim (if not exist)
# nix-shell -p vim

# 0. New machine
mkdir -p nix-dots/hosts/<your-machine> # create new hosts setup
vim nix-dots/hosts/<your-machine>/default.nix

# 1. Partitioning
lsblk -f
vim nix-dots/hosts/<your-machine>/disko.nix
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount nix-dots/hosts/<your-machine>/disko.nix

# 3. Check partition
mount | grep /mnt # verify auto mount. (important)

# 4. Generate hardware-configuration
nixos-generate-config --root /tmp/config --no-filesystems
cp /tmp/config/etc/nixos/hardware-configuration.nix nix-dots/hosts/<your-machine>

# 3. Install NixOS
nixos-install --flake ./nix-dots#<your-machine>

# 4. Enter new system
cp -r nix-dots /mnt/home/<user>
nixos-enter --root /mnt # enter your brand-new os
passwd <user>  # change user password
su <user>
chown -R <user>:users nix-dots
cd nix-dots/dots
mkdir -p ~/.config ~/.local/share
nix-shell -p gnumake stow
make link
exit 

# 4. Reboot
reboot
```

> Note: Use label instead of UUID for disko setup. Use label is way easier.


nix --experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' -- --write-efi-boot-entries --flake '/tmp/config/etc/nixos#mymachine' --disk main /dev/vda
