{
  programs.waybar.enable = true;
  programs.waybar.systemd.enable = true;

  home.file.".config/waybar/style.css".source = ./style.css;
  home.file.".config/waybar/scripts".source = ./scripts;
  home.file.".config/waybar/colors.css".source = ./colors.css;
  home.file.".config/waybar/config".source = ./config;
  home.file.".config/waybar/modules.json".source = ./modules.json;
}
