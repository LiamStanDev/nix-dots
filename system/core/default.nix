{ lib, ... }:

{
  imports = [
    ./boot.nix
    ./security.nix
    ./users.nix
    ./dm.nix
    ./env.nix
  ];

  documentation.dev.enable = true;

  i18n.defaultLocale = "en_US.UTF-8"; # 'i18n' means internationalisation

  time.timeZone = "Asia/Taipei";

  # compresses half the ram for use as swap
  zramSwap.enable = true;

  # WARN: don't touch this
  system.stateVersion = lib.mkDefault "23.05";
}
