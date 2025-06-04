{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    #./disko.nix
    ./packages.nix
    ./modules/bundle.nix
  ];

  disabledModules = [ ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "dev-liam";
  time.timeZone = "Asia/Taipei";
  i18n.defaultLocale = "en_US.UTF-8"; # 'i18n' means internationalisation

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.stateVersion = "23.05"; # WARN: don't change it!
}
