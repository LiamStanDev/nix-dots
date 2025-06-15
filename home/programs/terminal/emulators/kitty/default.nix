{self, ...}: {
  programs.kitty.enable = true;
  # programs.kitty = {
  #   enable = true;
  # font = {
  #   size = 10;
  #   name = "JetBrains Mono";
  # };
  #
  # settings = {
  #   scrollback_lines = 10000;
  #   confirm_os_window_close = 0;
  #   placement_strategy = "center";
  #
  #   allow_remote_control = "yes";
  #   enable_audio_bell = "no";
  #   visual_bell_duration = "0.1";
  #
  #   copy_on_select = "clipboard";
  #
  #   selection_foreground = "none";
  #   selection_background = "none";
  #
  #   # colors
  #   background_opacity = "0.8";
  # };
  #
  # themeFile = "Catppuccin-Frappe";
  # };

  home.file.".config/kitty".source = "${self}/dots/kitty";
}
