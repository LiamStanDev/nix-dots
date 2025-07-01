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
  programs.zed-editor.enable = true;

  # Video player
  programs.mpv.enable = true;

  # Connect to other devices
  services.kdeconnect.enable = true;

  # Note: I install app not only here but also flatpak. (comments is use flatpak)
  home.packages = with pkgs; [
    obsidian # Markdown-based note-taking app (don't use flatpak)
    bitwarden-desktop # Password manager (dot't use flatpak)
    pavucontrol # PulseAudio volume control GUI
    nautilus # GNOME file manager
    file-roller # GNOME compression manager (GUI)
    coolercontrol.coolercontrol-gui # fancontrol GUI
    coolercontrol.coolercontrol-ui-data # fancontrol UI data
    boxbuddy # GUI for managing your Distroboxes
    nvidia-system-monitor-qt # Nvidia monitor
  ];
}
