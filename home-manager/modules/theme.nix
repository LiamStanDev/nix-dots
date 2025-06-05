{ pkgs, ... }:

{
  # see: https://discourse.nixos.org/t/struggling-to-configure-gtk-qt-theme-on-laptop/42268/4
  # home.pointerCursor = {
  #   gtk.enable = true;
  #   package = pkgs.bibata-cursors;
  #   name = "Bibata-Modern-Classic";
  #   size = 16;
  # };


  home.pointerCursor = {
    gtk.enable = true;
    name = "Catppuccin-Macchiato-Dark-Cursors";
    package = pkgs.catppuccin-cursors.macchiatoDark;
    size = 16;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Frappe-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        variant = "frappe";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "frappe";
        accent = "blue";
      };
    };
    cursorTheme = {
      name = "Catppuccin-Frappe-Dark-Cursors";
      package = pkgs.catppuccin-cursors.frappeDark;
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };


  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Catppuccin-Frappe-Standard-Blue-Dark";
      color-scheme = "prefer-dark";
    };

    # For Gnome shell
    "org/gnome/shell/extensions/user-theme" = {
      name = "Catppuccin-Frappe-Standard-Blue-Dark";
    };
  };

  qt = {
    enable = true;
    platformTheme = {
      name = "qtct";
    };
    style.name = "kvantum";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
    General.theme = "Catppuccin-Macchiato-Blue";
  };
}
