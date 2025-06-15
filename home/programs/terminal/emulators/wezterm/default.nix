{self, ...}: {
  programs.wezterm.enable = true;

  home.file.".config/wezterm".source = "${self}/dots/wezterm";
}
