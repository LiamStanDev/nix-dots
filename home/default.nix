{
  imports = [
    ./programs
  ];

  home = {
    username = "liam";
    homeDirectory = "/home/liam";
    extraOutputsToInstall = ["doc" "devdoc"];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "xterm-256color";
    NIXOS_OZONE_WL = "1"; # hint Electron apps to use Wayland
  };

  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  # let HM manage itself when in standalone mode
  programs.home-manager.enable = true;

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # WARN: Please read the comment before changing.
}
