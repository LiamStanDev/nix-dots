# ──────── 🪟 Wayland / Hyprland ────────
{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./hypridle.nix
    ./hyprlock.nix
  ];

  # Waybar
  programs.waybar.enable = true;
  programs.waybar.systemd.enable = true;

  # Blueman Applet
  services.blueman-applet.enable = true;

  # Network Manager Applet
  services.network-manager-applet.enable = true;

  # Mako
  services.mako.enable = true;

  # Udiskie
  services.udiskie.enable = true;
  services.udiskie.tray = "always";

  # Clipboard manager
  services.cliphist.enable = true;

  # Polkit
  services.polkit-gnome.enable = true;

  # Wallpaper deamon
  services.swww.enable = true;

  home.packages = with pkgs; [
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
