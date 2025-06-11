{pkgs, ...}: {
  # see: https://discourse.nixos.org/t/struggling-to-configure-gtk-qt-theme-on-laptop/42268/4

  qt.enable = true;
  qt.platformTheme.name = "qtct"; # let qt5ct/qt6ct to handle Qt themes
  qt.style.name = "kvantum"; # kvantum as the Qt theme engine
  # create ~/.config/Kvantum/kvantum.kvconfig to alter the Kvantum theme
  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    General.theme = "Catppuccin-Frappe-Blue";
  };

  home.packages = with pkgs; [
    # ──────── 🎨 Qt/Theming ────────
    (catppuccin-kvantum.override {
      accent = "blue";
      variant = "frappe";
    }) # Kvantum theme with Catppuccin
    libsForQt5.qtstyleplugin-kvantum # Qt5 Kvantum plugin
    libsForQt5.qt5ct # Qt5 style configuration
  ];
}
