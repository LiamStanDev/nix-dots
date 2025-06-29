{pkgs, ...}: {
  # hardware.fancontrol.enable = true;
  programs.coolercontrol.enable = true;

  environment.systemPackages = with pkgs; [
    lm_sensors
  ];
}
