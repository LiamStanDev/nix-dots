{pkgs, ...}: {
  # see: https://discourse.nixos.org/t/struggling-to-configure-gtk-qt-theme-on-laptop/42268/4

  gtk.enable = true;

  gtk.cursorTheme.name = "Catppuccin-Macchiato-Dark-Cursors";
  gtk.cursorTheme.package = pkgs.catppuccin-cursors.macchiatoDark;

  gtk.theme.name = "adw-gtk3-dark";
  gtk.theme.package = pkgs.adw-gtk3;

  gtk.iconTheme.name = "Adwaita";
  gtk.iconTheme.package = pkgs.adwaita-icon-theme;

  gtk.font.name = "Inter";
  gtk.font.package = pkgs.google-fonts.override {fonts = ["Inter"];};
  gtk.font.size = 9;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "adw-gtk3-dark";
      color-scheme = "prefer-dark";
    };

    # For Gnome shell
    "org/gnome/shell/extensions/user-theme" = {
      name = "Catppuccin-Macchiato-Standard-Blue-Dark";
    };
  };
}
