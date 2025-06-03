{ inputs, ... }:

{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
    ./packages.nix
    ./modules/bundle.nix
  ];

  disabledModules = [ ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "dev-liam.laptop";
  time.timeZone = "Asia/Taipei";
  i18n.defaultLocale = "en_US.UTF-8"; # 'i18n' means internationalisation
  system.stateVersion = "24.11";

  documentation.man.enable = true;
  documentation.info.enable = true;
}
