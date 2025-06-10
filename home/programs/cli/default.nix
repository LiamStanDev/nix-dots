# ──────── 🐧 CLI Utilities ────────
{pkgs, ...}: {
  imports = [
    ./lazygit
    ./lazydocker
    ./zellij
    ./yazi
    ./starship
  ];

  programs.man.enable = true;
  programs.info.enable = true;
  programs.gpg.enable = true;
  programs.eza.enable = true;
  programs.zoxide.enable = true;
  programs.fzf.enable = true;
  programs.direnv.enable = true;

  home.packages = with pkgs; [
    fastfetch # System info fetcher (like neofetch)
    ntfs3g # NTFS filesystem support
    brightnessctl # Adjust screen brightness
    bluez # Bluetooth protocol stack
    bluez-tools # CLI utilities for bluez
    perf-tools # Linux perf wrapper scripts
    sysstat # Performance monitoring tools (iostat, etc.)
    netcat # Networking utility
    speedtest-cli # Test internet speed
    ripgrep # Fast grep alternative
    playerctl # Control media players
    pamixer # CLI PulseAudio volume controller
    cliphist # Clipboard history tool
    bottom # Modern `top` alternative
    bat # `cat` with syntax highlighting
    delta # Git diff viewer with syntax highlighting
    tealdeer # Fast `tldr` client
    cacert # SSL certificates
    chafa # Terminal image preview
    trash-cli # Send files to trash from CLI
    jq # Command-line JSON processor
    neovim # Modern Vim-based editor
    direnv # Per-directory env vars
    starship # Minimal shell prompt
    vim # Terminal text editor
    git # Version control
    htop # Interactive process viewer
    duf # Disk usage viewer
    dust # Disk usage analyzer
    fd # Fast alternative to `find`
    stow # Symlink manager
    unzip # Extract zip files
    wget # Network downloader
    openssl # SSL/TLS toolkit
  ];
}
