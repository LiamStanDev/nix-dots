{pkgs, ...}: {
  # graphics drivers / HW accel
  hardware.graphics = {
    enable = true; # include openGL

    extraPackages = with pkgs; [
      libva
      vaapiVdpau
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
