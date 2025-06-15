{self, ...}: {
  programs.kitty.enable = true;

  home.file.".config/kitty".source = "${self}/dots/kitty";
}
