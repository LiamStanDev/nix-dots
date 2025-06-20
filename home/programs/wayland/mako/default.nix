{
  config,
  lib,
  ...
}: let
  cfg = config.wayland.mako;
in {
  options.wayland.mako.enable = lib.mkEnableOption "Mako notification daemon for Wayland";

  config = lib.mkIf cfg.enable {
    # Mako
    services.mako.enable = true;
    services.mako.extraConfig = ''
      layer=top
      background-color=#1e1e2eee
      border-size=2
      border-color=#74c7ec
      border-radius=8
      default-timeout=10000
      font=Noto Sans 12
      #output=eDP-1

      [urgency=high]
      layer=overlay
      border-color=#f38ba8

      [desktop-entry="org.telegram.desktop"]
      layer=top
      border-color=#74c7ec

      [desktop-entry="org.gnome.Fractal"]
      layer=top
      border-color=#74c7ec

      [mode=dnd]
      invisible=1
    '';
  };
}
