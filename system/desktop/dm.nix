{
  self,
  inputs,
  pkgs,
  ...
}: let
  sddm-sugar-dark = import "${self}/pkgs/sddm-sugar-dark.nix" {inherit pkgs;};
in {
  environment.systemPackages = [sddm-sugar-dark];

  # GDM (may crash when using hyprland)
  # services.desktopManager.plasma6.enable = true;

  # SDDM
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      extraPackages = with pkgs; [
        libsForQt5.qt5.qtquickcontrols2 # for sddm-sugar-dark
        libsForQt5.qt5.qtgraphicaleffects # for sddm-sugar-dark
      ];
      theme = "sugar-dark";
    };
  };

  # hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = pkgs.hyprland;
  };
  services.displayManager.defaultSession = "hyprland";
}
