{
  self,
  # inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    hyprpanel
    bluez
    bluez-tools
    gvfs
    wf-recorder # screen record
    btop
    hyprpicker
    hyprsunset
    brightnessctl
    gpustat
  ];
}
