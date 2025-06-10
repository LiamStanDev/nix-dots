{pkgs, ...}: {
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-gtk
        kdePackages.fcitx5-qt
        fcitx5-chinese-addons
        fcitx5-table-extra
        fcitx5-chewing
        libsForQt5.fcitx5-configtool
      ];
    };
  };
}
