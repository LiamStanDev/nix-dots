# ──────── 🖥️ Desktop Applications ────────
{
  inputs,
  pkgs,
  ...
}: {
  # Streaming
  programs.obs-studio.enable = true;

  # Video player
  programs.mpv.enable = true;

  # Connect to other devices
  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    vscode # code editor
    discord # all-in-one voice and text chat for gamers
    zed-editor # code editor
    obsidian # Markdown-based note-taking app (don't use flatpak)
    bitwarden-desktop # Password manager (dot't use flatpak)
    pavucontrol # PulseAudio volume control GUI
    nautilus # GNOME file manager
    file-roller # GNOME compression manager (GUI)
    coolercontrol.coolercontrol-gui # fancontrol GUI
    coolercontrol.coolercontrol-ui-data # fancontrol UI data
    boxbuddy # GUI for managing your Distroboxes
    virt-viewer # virtual machine viewer
    gedit # editor
    foliate # book reader
    gnome-frog # text extractor for images and PDFs
    postman # API development environment
    pgadmin4 # postgres database management tool
    spotify # music streaming service
    telegram-desktop # messaging app
    zoom-us # conference software
    gimp # image editor
    loupe # image viewer
  ];
}
