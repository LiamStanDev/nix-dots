{ pkgs, ... }:

# see: https://discourse.nixos.org/t/struggling-to-configure-gtk-qt-theme-on-laptop/42268/4
{
  # Qt
  qt.enable = true;
  qt.platformTheme.name = "qtct"; # let qt5ct/qt6ct to handle Qt themes
  qt.style.name = "kvantum"; # kvantum as the Qt theme engine
  # create ~/.config/Kvantum/kvantum.kvconfig to alter the Kvantum theme
  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
    General.theme = "Catppuccin-Frappe-Blue";
  };

  # GTK
  gtk.enable = true;

  gtk.cursorTheme.name = "Catppuccin-Macchiato-Dark-Cursors";
  gtk.cursorTheme.package = pkgs.catppuccin-cursors.macchiatoDark;

  gtk.theme.name = "adw-gtk3-dark";
  gtk.theme.package = pkgs.adw-gtk3;

  gtk.iconTheme.name = "Adwaita";
  gtk.iconTheme.package = pkgs.adwaita-icon-theme;

  gtk.font.name = "Sans";
  gtk.font.size = 11;
}
