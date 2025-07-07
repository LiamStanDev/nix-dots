{
  pkgs,
  wheelUser,
  ...
}: {
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud # Vulkan and OpenGL overlay for monitoring FPS, CPU, and etc.
    protonup # Update proton
    protonplus # proton management tool

    # other game launcher
    heroic # game launcher
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${wheelUser}/.steam/root/compatibilitytools.d";
  };
}
