# My Linux Dotfiles 👑

This repository contains my personal NixOS and Home-Manager configurations, managed centrally using [Nix Flake](https://nixos.wiki/wiki/Flakes). It provides modular, version-controlled management for system, desktop, application, and user-level settings.

---

## Directory Structure

- `flake.nix`: Flake entry point, defines NixOS and Home-Manager inputs and outputs.
- `hosts/`: Per-host NixOS configurations (e.g., `vivo`).
- `system/`: System-level NixOS modules (hardware, network, services, etc.).
- `home/`: Home-Manager user-level modules and settings.
- `pkgs/`: Custom Nix packages or scripts (e.g., the `switch` tool).
- `dot-desktop/`: Desktop application configs (rofi, kitty, wezterm, waybar, etc.).
- `dot-config/`: Application config files (nvim, yazi, btop, lazygit, etc.).
- `scripts/`: Helper scripts for installation and removal.



## Installation Guide

```bash
sudo -i

# 1. Get this nix configuration
cd nix-dots/hosts/<your-machine>

# 1. Partitioning
nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./disko.nix --yes-wipe-all-disks
mount | grep /mnt # verify auto mount. (important)

# 2. Editing system
nixos-generate-config --root /mnt
vim /mnt/etc/nixos/configuration.nix

# 3. Install NixOS
nixos-install

# 4. Copy hardware-configuration.nix file
nixos-enter --root /mnt # enter your brand-new os
passwd <user>  # change user password
cd /home/<user>
git clone https://github.com/LiamStanDev/nix-dots.git
cp /ect/nixos/hardware-configuration.nix /home/<user>/nix-dots/hosts/<host>
exit 

# 4. Reboot
reboot
```

> Note: Use label instead of UUID for disko setup. label is way easier
