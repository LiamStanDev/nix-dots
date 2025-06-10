# ──────── 🖥️ Desktop Applications ────────
{pkgs, ...}: {
  programs.wezterm.enable = true;

  home.packages = with pkgs; [
    google-chrome # Chromium-based web browser
    telegram-desktop # Messaging app
    obs-studio # Screen recording/streaming software
    discord # Voice, video, and chat app
    obsidian # Markdown-based note-taking app
    pgadmin4-desktopmode # PostgreSQL GUI management
    spotify # Music streaming app
    postman # API testing tool
    bitwarden-desktop # Password manager
    vscode # Visual Studio Code IDE
    pavucontrol # PulseAudio volume control GUI
    nautilus # GNOME file manager
    virt-manager # Virtual machine GUI frontend
  ];
}
