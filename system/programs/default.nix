{
  imports = [
    ./fonts.nix
    ./home-manager.nix
    ./xdg.nix
  ];

  programs = {
    # configuration system for GNOME/GTK applications
    dconf.enable = true;

    # connect your phone to your computer
    kdeconnect.enable = true;

    # managing passwords and encryption keys
    seahorse.enable = true;
  };
}
