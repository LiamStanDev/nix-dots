{
  pkgs,
  pkgs-stable,
  ...
}: {
  documentation.man.enable = true;
  documentation.info.enable = true;

  environment.systemPackages = with pkgs; [
    # ──────── 🚀 Boot Theme ────────
    # catppuccin-grub          # GRUB theme with Catppuccin style

    # ──────── 🖥️ Virtualization / Containers / K8s ────────
    docker # Container engine
    kubectl # Kubernetes CLI
    qemu_full # Full system emulation
    qemu-user # QEMU user-mode emulation
    qemu-utils # QEMU tools (e.g., `qemu-img`)
    libvirt # Virtualization management daemon

    # ──────── 🪟 Wayland / Hyprland ────────
    hyprland # Dynamic Wayland compositor
    hyprland-protocols # Hyprland-specific protocols
    seatd # Seat management daemon
    hyprpicker # Color picker
    hypridle # Idle manager for Hyprland
    gnome-keyring # Keyring daemon
    polkit_gnome # Polkit agent for authentication
    udiskie # Automounter for udisks
    networkmanagerapplet # NetworkManager GUI applet
    waybar # Status bar for Wayland
    mako # Notification daemon
    swww # Wallpaper daemon
    rofi-wayland # Application launcher
    grim # Screenshot tool
    slurp # Select area for grim
    swaylock-effects # Lock screen with effects
    libnotify # Notification support
    wl-clipboard # Clipboard support
    xwayland # X11 compatibility layer for Wayland
  ];
}
