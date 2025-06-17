# ref: https://github.com/Sly-Harvey/NixOS/blob/master/modules/hardware/video/nvidia.nix
# ref: https://discourse.nixos.org/t/black-screen-after-suspend-hibernate-with-nvidia/54341/22
{
  config,
  pkgs,
  lib,
  ...
}: let
  nvidiaDriverChannel = config.boot.kernelPackages.nvidiaPackages.latest; # stable, latest, beta, etc.
in {
  environment.sessionVariables = lib.optionalAttrs config.programs.hyprland.enable {
    NVD_BACKEND = "direct";
    GBM_BACKEND = "nvidia-drm";
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # MOZ_DISABLE_RDD_SANDBOX = 1; # Potential security risk

    __GL_GSYNC_ALLOWED = "1"; # GSync
  };

  # Load nvidia driver for Xorg and Wayland and setup every thing you need
  services.xserver.videoDrivers = ["nvidia"]; # or "nvidiaLegacy470", etc.

  hardware.nvidia = {
    open = false;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = nvidiaDriverChannel;

    # Modesetting is required. (wayland)
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  nixpkgs.config = {
    nvidia.acceptLicense = true;
    cudaSupport = true;
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "cudatoolkit"
        "nvidia-persistenced"
        "nvidia-settings"
        "nvidia-x11"
      ];
  };
  nix.settings = {
    substituters = ["https://cuda-maintainers.cachix.org"];
    trusted-public-keys = ["cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="];
  };
}
