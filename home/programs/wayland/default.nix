{
  self,
  pkgs,
  ...
}: {
  imports = [
    ./hyprland
    ./hyprlock
    ./hypridle
    ./hyprpanel
    ./mako
  ];

  home.packages = [
    (import "${self}/pkgs/screenshot.nix" {inherit pkgs;})
  ];
}
