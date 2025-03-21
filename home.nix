{ config, pkgs, ... }:

{
  home.username = "liam";
  home.homeDirectory = "/home/liam";

  nixpkgs.config.allowUnfree = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # WARN: Please read the comment before changing.

  imports = [
    ./modules/packages.nix
    ./modules/git.nix
  ];
}
