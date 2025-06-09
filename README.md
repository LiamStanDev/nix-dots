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

