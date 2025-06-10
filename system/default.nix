let
  minimal = [
    ./nix
    ./core
    ./network
  ];

  desktop =
    minimal
    ++ [
      ./hardware/graphics.nix

      ./services/dubs.nix
      ./services/fwupd.nix
      ./services/psd.nix
      ./services/pipewire.nix

      ./desktop/dm.nix
      ./desktop/fonts.nix
    ];

  laptop =
    desktop
    ++ [
      ./hardware/battery.nix
      ./hardware/bluetooth.nix
      ./packages.nix
    ];
in {
  inherit minimal desktop laptop;
}
