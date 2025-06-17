{
  self,
  config,
  lib,
  ...
}: let
  cfg = config.emulators.wezterm;
in {
  options.emulators.wezterm.enable = lib.mkEnableOption "WezTerm terminal emulator";

  config = lib.mkIf cfg.enable {
    programs.wezterm.enable = true;

    home.file.".config/wezterm".source = "${self}/dots/wezterm";
  };
}
