{
  config,
  lib,
  ...
}: let
  cfg = config.emulators.ghostty;
in {
  options.emulators.ghostty.enable = lib.mkEnableOption "Ghostty terminal emulator";

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;

      settings = {
        theme = "catppuccin-frappe";
        font-size = 13;
        font-family = [
          "JetBrains Mono"
          "CaskaydiaCove Nerd Font"
          "Yozai"
          "Noto Color Emoji"
        ];

        keybind = [
          # "ctrl+alt+h=goto_split:left"
          # "ctrl+alt+l=goto_split:right"
          # "ctrl+alt+k=goto_split:up"
          # "ctrl+alt+j=goto_split:down"

          # "ctrl+shift+c=copy_to_clipboard"
          # "ctrl+shift+v=paste_from_clipboard"
          #
          # "ctrl+alt+u=increase_font_size"
          # "ctrl+alt+d=decrease_font_size"
        ];

        background-opacity = 0.95;
        window-padding-x = "10, 10";
        window-padding-y = "4, 7";
        window-decoration = "none";
        confirm-close-surface = false;
      };

      themes = {
        catppuccin-mocha = {
          background = "1e1e2e";
          cursor-color = "f5e0dc";
          foreground = "cdd6f4";
          palette = [
            "0=#45475a"
            "1=#f38ba8"
            "2=#a6e3a1"
            "3=#f9e2af"
            "4=#89b4fa"
            "5=#f5c2e7"
            "6=#94e2d5"
            "7=#bac2de"
            "8=#585b70"
            "9=#f38ba8"
            "10=#a6e3a1"
            "11=#f9e2af"
            "12=#89b4fa"
            "13=#f5c2e7"
            "14=#94e2d5"
            "15=#a6adc8"
          ];
          selection-background = "353749";
          selection-foreground = "cdd6f4";
        };

        catppuccin-frappe = {
          background = "303446";
          cursor-color = "f2d5cf";
          foreground = "c6d0f5";
          palette = [
            "0=#51576d"
            "1=#e78284"
            "2=#a6d189"
            "3=#e5c890"
            "4=#8caaee"
            "5=#f4b8e4"
            "6=#81c8be"
            "7=#b5bfe2"
            "8=#626880"
            "9=#e78284"
            "10=#a6d189"
            "11=#e5c890"
            "12=#8caaee"
            "13=#f4b8e4"
            "14=#81c8be"
            "15=#a5adce"
          ];
          selection-background = "414559";
          selection-foreground = "c6d0f5";
        };
      };
    };
  };
}
