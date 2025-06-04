{
  # GDM
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;

  # hyprland
  programs.hyprland.enable = true;
  services.displayManager.defaultSession = "hyprland";
}
