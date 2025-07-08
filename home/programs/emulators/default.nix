{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    wezterm
    kitty
    inputs.ghostty.packages.${pkgs.system}.default
    foot
  ];
}
