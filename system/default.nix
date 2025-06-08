let
  desktop = [
    ./nix
    ./core
    ./hardware
    ./network
    ./programs
    ./services
    ./packages.nix
  ];

  laptop =
    desktop ++ [
      ./hardware/bluetooth.nix

      ./services/power.nix
      ./services/backlight.nix
    ];

in
{
  inherit desktop laptop;
}
