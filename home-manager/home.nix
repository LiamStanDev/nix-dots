{ pkgs, ... }:

{
  home.username = "liam";
  home.homeDirectory = "/home/liam";


  imports = [
    ./packages.nix
    # ./modules
  ];

  home.sessionVariables = {
    SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
    TERM = "xterm-256color";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_RUNTIME_DIR = "/run/user/$UID";
    XDG_DESKTOP_DIR = "$HOME/Desktop";
    XDG_DOWNLOAD_DIR = "$HOME/Downloads";
    XDG_TEMPLATES_DIR = "$HOME/Templates";
    XDG_PUBLICSHARE_DIR = "$HOME/Public";
    XDG_DOCUMENTS_DIR = "$HOME/Documents";
    XDG_MUSIC_DIR = "$HOME/Music";
    XDG_PICTURES_DIR = "$HOME/Pictures";
    XDG_VIDEOS_DIR = "$HOME/Videos";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # WARN: Please read the comment before changing.
}
