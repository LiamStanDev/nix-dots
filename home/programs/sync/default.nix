{
  config,
  lib,
  ...
}: let
  cfg = config.sync;
in {
  options.sync.enable = lib.mkEnableOption "Sync";
  config = lib.mkIf cfg.enable {
    services.syncthing.enable = true;
    services.syncthing.tray.enable = true;
  };
}
