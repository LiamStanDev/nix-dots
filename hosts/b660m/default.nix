{
  self,
  inputs,
  wheelUser,
  ...
}: let
  # Import the 'laptop' module from the system directory
  inherit (import "${self}/system") desktop;

  monitors = [
    # home monitor
    "desc:ASUSTek COMPUTER INC VG27A N8LMQS004677, 2560x1440, 0x0, 1"
    "desc:LG Electronics LG HDR 4K 0x000641E,3840x2160,2560x0,1.5"
    # "desc:LG Electronics LG HDR 4K 0x000641E, 2560x1440, 2560x0, 1"
  ];

  workspace = [
    # home monitor
    "1, monitor:desc:ASUSTek COMPUTER INC VG27A N8LMQS004677"
    "2, monitor:desc:ASUSTek COMPUTER INC VG27A N8LMQS004677"
    "3, monitor:desc:ASUSTek COMPUTER INC VG27A N8LMQS004677"
    "4, monitor:desc:ASUSTek COMPUTER INC VG27A N8LMQS004677"
    "5, monitor:desc:ASUSTek COMPUTER INC VG27A N8LMQS004677"
    "6, monitor:desc:LG Electronics LG HDR 4K 0x000641E"
    "7, monitor:desc:LG Electronics LG HDR 4K 0x000641E"
    "8, monitor:desc:LG Electronics LG HDR 4K 0x000641E"
    "9, monitor:desc:LG Electronics LG HDR 4K 0x000641E"
    "0, monitor:desc:LG Electronics LG HDR 4K 0x000641E"
  ];
in rec {
  # Import base laptop modules and additional configuration files
  imports =
    desktop
    ++ [
      # Disk
      ./disko.nix
      # Hardware
      ./hardware-configuration.nix

      # System
      "${self}/system/hardware/video/intel.nix"
      "${self}/system/hardware/video/nvidia.nix"
      "${self}/system/hardware/bluetooth.nix"
      "${self}/system/hardware/razer.nix"
      "${self}/system/network"
      "${self}/system/network/tailscale.nix"
      "${self}/system/network/avahi.nix"
      "${self}/system/network/spotify.nix"
      "${self}/system/virt"
      "${self}/system/gaming"

      # Home manager
      ../../system/home-manager.nix
      {
        home-manager.users.${wheelUser} = "${self}/home/profiles/${networking.hostName}.nix";
        home-manager.extraSpecialArgs = {inherit self inputs wheelUser monitors workspace;};
      }
    ];

  # Set the hostname for this machine
  networking.hostName = "b660m";

  # Sensor devices for coolercontrol
  boot.kernelModules = ["nct6775"];
  # Force pwm mode
  boot.kernelParams = ["nct6775.force_pwm=1"];

  services = {
    # Enable fstrim service to keep SSDs and NVMe drives healthy
    fstrim.enable = true;
  };
}
