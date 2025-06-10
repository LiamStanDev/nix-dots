{
  programs.zellij.enable = true;

  home.file.".config/zellij/layouts".source = ./layouts;
  home.file.".config/zellij/config.kdl".source = ./config.kdl;
}
