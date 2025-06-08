{ pkgs, config, ... }:

{
  boot = {
    bootspec.enable = true;

    # initial ramdisk
    initrd = {
      systemd.enable = true;
      supportedFilesystems = [ "btrfs" ];
    };
    initrd.kernelModules = [ "i915" ];

    # use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "quiet"
      "loglevel=3"
      "rd.udev.log_level=3" # ramdisk udev log level
      "splash" # show animation on boot
    ];
    kernelModules = [ ];

    # bootloader
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        device = "nodev";
        theme = "${(pkgs.catppuccin-grub.override { flavor = "frappe"; })}";
      };
    };

    # boot animation
    plymouth = {
      enable = true;
      theme = "catppuccin-frappe";

      themePackages = with pkgs; [
        (catppuccin-plymouth.override { variant = "frappe"; })
      ];
    };
  };

  environment.systemPackages = [ config.boot.kernelPackages.cpupower ];
}
