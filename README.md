# ✨ My Linux Dotfiles 👑

Welcome to my personal dotfiles repo! This is my all-in-one setup for NixOS and Home-Manager, powered by [Nix Flake](https://nixos.wiki/wiki/Flakes). Here you'll find a modular, reproducible, and *fun* way to manage your entire Linux environment—from system configs to the tiniest app tweak.

---

## 🗂️ Directory Structure

- `flake.nix`: Flake entry point, defines NixOS and Home-Manager inputs and outputs.
- `hosts/`: Per-host NixOS configurations (e.g., `vivo`).
- `system/`: System-level NixOS modules (hardware, network, services, etc.).
- `home/`: Home-Manager user-level modules and settings.
- `pkgs/`: Custom Nix packages or scripts (e.g., the `switch` tool).
- `dots/`: Application configs (rofi, kitty, wezterm, waybar, etc.).
- `scripts/`: Helper scripts for installation and removal.


---

## 🚀 Installation Guide

Ready to supercharge your Linux box? Follow these steps!

```bash
sudo -i

git clone https://github.com/LiamStanDev/nix-dots.git

# Optionally: install vim if you don't have it
# nix-shell -p vim

# 0. New machine
mkdir -p nix-dots/hosts/<your-machine> # create new hosts setup
vim nix-dots/hosts/<your-machine>/default.nix

# 1. Partitioning
lsblk -f
vim nix-dots/hosts/<your-machine>/disko.nix
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount nix-dots/hosts/<your-machine>/disko.nix

# 2. Check partition
mount | grep /mnt # verify auto mount. (important)

# 3. Generate hardware-configuration
nixos-generate-config --root /tmp/config --no-filesystems
cp /tmp/config/etc/nixos/hardware-configuration.nix nix-dots/hosts/<your-machine>

# 4. Install NixOS
nixos-install --flake ./nix-dots#<your-machine>

# 5. Enter new system
cp -r nix-dots /mnt/home/<user>
nixos-enter --root /mnt # enter your brand-new os
passwd <user>  # change user password
su <user>
chown -R <user>:users nix-dots
cd nix-dots/dots
mkdir -p ~/.config ~/.local/share ~/.config/hypr
nix-shell -p gnumake stow
make link
exit 

# 6. Reboot
reboot
```

> **Note:** Use labels instead of UUIDs for disko setup. Labels are way easier to manage!

---

## 🎉 Features

- **Modular**: Mix and match configs for any machine or user.
- **Reproducible**: Your setup, anywhere, anytime.
- **App configs**: Pre-tuned for a beautiful desktop (Hyprland, Yazi, Kitty, and more).
- **Plugin power**: Includes custom Yazi plugins and Catppuccin themes.
- **Fun to hack**: Tweak, break, and fix—it's all versioned!

---

## 📝 License

MIT for everything unless otherwise noted. See individual folders for details.

---

## 🤝 Contributing

PRs and issues welcome! Fork, hack, and share your improvements.

---

## 💬 Contact

Find me on GitHub: [LiamStanDev](https://github.com/LiamStanDev)

Happy hacking! 🚀
