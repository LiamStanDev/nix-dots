# ──────── 🐧 CLI Utilities ────────
{
  inputs,
  lib,
  config,
  pkgs,
}: let
  cfg = config.boundle.cli;
in {
  optinos.boundle.cli = {enable = lib.mkEnableOption "cli";};

  config = lib.mkIf cfg.enable {
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
      zellij # Terminal multiplexer (tmux alternative)
      tealdeer # Fast `tldr` client
      cacert # SSL certificates
      chafa # Terminal image preview
      eza # Enhanced `ls` with icons/colors
      fzf # Command-line fuzzy finder
      yazi # Terminal file manager
      zoxide # Smarter `cd` command
      trash-cli # Send files to trash from CLI
      jq # Command-line JSON processor
      neovim # Modern Vim-based editor
      lazygit # TUI for git
      lazydocker # TUI for Docker
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
  };
}
