{ pkgs, ... }:


{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        device = "nodev";
        # theme = "${pkgs.catppuccin-grub}/share/grub/themes/frappe";
      };
    };

    plymouth = {
      enable = true;
      theme = "catppuccin-frappe";

      themePackages = with pkgs; [
        (catppuccin-plymouth.override { variant = "frappe"; })
      ];
    };

    kernelParams = [ "quiet" "splash" "loglevel=3" ];
    initrd.kernelModules = [ "i915" ];
    kernelModules = [ "kvm-intel" ];
  };

  services.xserver.videoDrivers = [ "i915" "intel" ];
}
