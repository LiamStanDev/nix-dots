# see: https://wiki.hypr.land/Hypr-Ecosystem/hypridle/
{pkgs, ...}: {
  services.hypridle.enable = true;

  home.packages = with pkgs; [
    hypridle
  ];
}
