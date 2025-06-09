{ pkgs, config, ... }:

{
  boot = {
    bootspec.enable = true;

    # Kernel version
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "quiet"
      "loglevel=3"
      "rd.udev.log_level=3" # ramdisk udev log level
      "splash" # show animation on boot
    ];

    # Bootloader
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

    # Boot animation
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
