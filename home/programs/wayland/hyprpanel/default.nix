{
  pkgs,
  inputs,
  ...
}: {
  # this will override config
  # programs.hyprpanel = {
  #   enable = true;
  #   package = inputs.hyprpanel.packages.${pkgs.system}.default;
  # };

  home.packages = with pkgs; [
    inputs.hyprpanel.packages.${pkgs.system}.default
    bluez
    bluez-tools
    gvfs
    wf-recorder # screen record
    hyprpicker
    hyprsunset
    brightnessctl
    gpustat
  ];
}
