{
  self,
  config,
  lib,
  ...
}: let
  cfg = config.emulators.kitty;
in {
  options.emulators.kitty.enable = lib.mkEnableOption "Kitty terminal emulator";

  config = lib.mkIf cfg.enable {
    programs.kitty.enable = true;

    home.file.".config/kitty".source = "${self}/dots/kitty";
  };
}
