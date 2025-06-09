{ lib, ... }:

{
  imports = [
    ./boot.nix
    ./security.nix
    ./users.nix
    ./env.nix
  ];

  documentation.dev.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  # don't touch this
  system.stateVersion = lib.mkDefault "23.11";

  time.timeZone = lib.mkDefault "Asia/Taipei";

  zramSwap.enable = true;
}
