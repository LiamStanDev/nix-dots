let
  minimal = [
    ./nix
    ./core
    ./network
  ];

  desktop =
    minimal
    ++ [
      ./hardware/video/intel.nix
      ./hardware/sound.nix
      ./hardware/battery.nix

      ./services/dubs.nix
      ./services/fwupd.nix
      ./services/psd.nix

      ./desktop/dm.nix
      ./desktop/fonts.nix
      ./desktop/flatpak.nix
    ];

  laptop =
    desktop
    ++ [
      ./hardware/bluetooth.nix
    ];
in {
  inherit minimal desktop laptop;
}
