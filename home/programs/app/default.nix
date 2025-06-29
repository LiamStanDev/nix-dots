# ──────── 🖥️ Desktop Applications ────────
{
  inputs,
  pkgs,
  ...
}: {
  # Streaming
  programs.obs-studio.enable = true;

  # Editor
  programs.vscode.enable = true;

  # Video player
  programs.mpv.enable = true;

  # Connect to other devices
  services.kdeconnect.enable = true;

  # Game
  programs.lutris.enable = true;

  # Note: I install app not only here but also flatpak. (comments is use flatpak)
  home.packages = with pkgs; [
    obsidian # Markdown-based note-taking app
    bitwarden-desktop # Password manager
    pavucontrol # PulseAudio volume control GUI
    nautilus # GNOME file manager
    file-roller # GNOME compression manager (GUI)
    gedit # text editor GUI for Gnome
    coolercontrol.coolercontrol-gui # fancontrol GUI
    coolercontrol.coolercontrol-ui-data # fancontrol UI data
    loupe # Image viewer (GTK)
  ];
}
