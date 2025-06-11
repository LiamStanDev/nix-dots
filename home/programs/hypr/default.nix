# ──────── 🪟 Wayland / Hyprland ────────
{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./hypridle.nix
    ./hyprlock.nix
  ];

  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland,x11,*";
    QT_QPA_PLATFORM = "wayland;xcb";
    CLUTTER_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";

    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    # Solve cursor invisible in wayland
    WLR_NO_HARDWARE_CURSORS = "1";
  };

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
  services.cliphist.allowImages = true;

  # Polkit
  services.polkit-gnome.enable = true;

  # Wallpaper deamon
  services.swww.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [];

  home.packages = with pkgs; [
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
    libnotify # Notification support (notify-deamon needs)
    wl-clipboard # Clipboard support
    xwayland # X11 compatibility layer for Wayland
  ];
}
