# ──────── 🪟 Wayland / Hyprland ────────
{
  self,
  inputs,
  pkgs,
  lib,
  monitors,
  workspace,
  ...
}: {
  # Env
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

  # Packags
  home.packages = with pkgs; [
    seatd # Seat management daemon
    hyprpicker # Color picker
    rofi-wayland # Application launcher
    grim # Screenshot tool
    slurp # Select area for grim
    libnotify # Notification support (notify-deamon needs)
    wl-clipboard # Clipboard support
    rofi-wayland # App launcher
  ];

  # Programs
  # Blueman Applet
  # services.blueman-applet.enable = true;
  # Network Manager Applet
  # services.network-manager-applet.enable = true;
  # Auto mount
  services.udiskie.enable = true;
  services.udiskie.tray = "always";
  # Clipboard manager
  services.cliphist.enable = true;
  services.cliphist.allowImages = true;
  # Polkit
  services.polkit-gnome.enable = true;
  # Wallpaper deamon
  services.swww.enable = true;
  # Keyring
  services.gnome-keyring.enable = true;
  # Waybar
  # programs.waybar.enable = true;
  # programs.waybar.systemd.enable = true;
  # XDG
  xdg.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
  ];
  xdg.portal.xdgOpenUsePortal = true;

  wayland.windowManager.hyprland = {
    enable = true; # also enable hyprland-protocols
    systemd.enable = true;
    systemd.variables = ["--all"]; # add $PATH to systemd

    settings = lib.mkMerge [
      (import ./binds.nix {inherit self pkgs;})
      (import ./rules.nix)
      (import ./settings.nix {inherit self pkgs monitors workspace;})
    ];
  };
}
