{pkgs, ...}: {
  home.packages = with pkgs; [
    wezterm
    kitty
    ghostty
    foot
  ];
}
