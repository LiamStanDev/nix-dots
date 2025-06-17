{
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.eza.enableBashIntegration = true;
  programs.zoxide.enableBashIntegration = true;
  programs.fzf.enableBashIntegration = true;
  programs.direnv.enableBashIntegration = true;
  programs.zellij.enableBashIntegration = true;
  programs.yazi.enableBashIntegration = true;
}
