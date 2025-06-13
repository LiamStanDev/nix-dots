# ──────── 🖥️ Desktop Applications ────────
{pkgs, ...}: {
  programs.wezterm.enable = true;
  programs.obs-studio.enable = true;
  programs.vscode.enable = true;

  home.packages = with pkgs; [
    google-chrome # Chromium-based web browser
    telegram-desktop # Messaging app
    obsidian # Markdown-based note-taking app
    pgadmin4-desktopmode # PostgreSQL GUI management
    spotify # Music streaming app
    postman # API testing tool
    bitwarden-desktop # Password manager
    pavucontrol # PulseAudio volume control GUI
    nautilus # GNOME file manager
    file-roller # GNOME compression manager (GUI)
    discord # Online text and voice chat
    gedit # text editor GUI for Gnome
    coolercontrol.coolercontrol-gui # fancontrol GUI
    coolercontrol.coolercontrol-ui-data # fancontrol UI data
  ];
}
