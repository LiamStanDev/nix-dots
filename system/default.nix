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
      ./hardware/sound.nix
      ./hardware/auto-mount.nix
      ./hardware/fancontrol.nix

      ./services/dubs.nix
      ./services/fwupd.nix
      ./services/psd.nix

      ./desktop/dm.nix
      ./desktop/fonts.nix
    ];

  laptop =
    desktop
    ++ [
      ./hardware/battery.nix
      ./hardware/bluetooth.nix
    ];
in {
  inherit minimal desktop laptop;
}
