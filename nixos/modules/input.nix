{ pkgs, ... }:

{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-gtk
        rime-data
        fcitx5-rime
        libsForQt5.fcitx5-configtool
        kdePackages.fcitx5-qt
      ];
    };
  };
}
