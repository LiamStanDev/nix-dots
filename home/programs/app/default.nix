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
    libsForQt5.okular # PDF reader
    gimp3 # Image editor
    loupe # Image viewer (GTK)
    inputs.zen-browser.packages."${pkgs.system}".default
    (bottles.override {removeWarningPopup = true;}) # Windows software using Wine
  ];
}
