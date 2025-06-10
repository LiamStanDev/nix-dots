{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      add_newline = true;
      scan_timeout = 10;
      container.disabled = true;
    };
  };
}
