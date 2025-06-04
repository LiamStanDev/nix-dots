{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        device = "nodev";
      };
    };

    plymouth = {
      enable = true;
      theme = "bgrt";
    };

    kernelParams = [ "quiet" "splash" "loglevel=3" ];
    initrd.kernelModules = [ "i915" ];
    kernelModules = [ "kvm-intel" ];
  };

  services.xserver.videoDrivers = [ "i915" "intel" ];
}
