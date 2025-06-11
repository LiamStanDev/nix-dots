# top level attribute info: https://www.reddit.com/r/NixOS/comments/1i2yf86/attempt_at_explaining_toplevel_attributes_and_how/
{
  imports = [
    ./programs/cli
    ./programs/dev
    ./programs/app
    ./programs/virt
    ./programs/theme
    ./programs/git
    ./programs/ssh
    ./programs/terminal/shell
    ./programs/terminal/emulators

    ./programs/wayland/hypr

    ./programs/im.nix
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
