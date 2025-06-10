{
  programs.wezterm.enable = true;

  home.file.".config/wezterm/wezterm.lua".source = ./wezterm.lua;
  home.file.".config/wezterm/colors".source = ./colors;
  home.file.".config/wezterm/config".source = ./config;
  home.file.".config/wezterm/events".source = ./events;
  home.file.".config/wezterm/utils".source = ./utils;
}
