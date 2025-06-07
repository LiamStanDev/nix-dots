{ pkgs-stable, ... }:

{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs-stable; [
        fcitx5-gtk
        kdePackages.fcitx5-qt
        fcitx5-chinese-addons
        fcitx5-rime
      ];

      settings.globalOptions = {
        Hotkey = {
          EnumerateWithTriggerKeys = true;
          AltTriggerKeys = "";
          EnumerateForwardKeys = "";
          EnumerateBackwardKeys = "";
          EnumerateSkipFirst = "";
          EnumerateGroupForwardKeys = "";
          EnumerateGroupBackwardKeys = "";
        };
      };
    };
  };
}
