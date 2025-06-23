# ──────── 🐧 CLI Utilities ────────
{
  self,
  pkgs,
  ...
}: {
  imports = [
    ./yazi
    ./starship
  ];

  # Env
  home.sessionVariables = {
    # Prevent direnv show lots of logs
    DIRENV_LOG_FORMAT = "";
  };

  # Programs
  programs.man.enable = true;
  programs.info.enable = true;
  programs.gpg.enable = true;
  programs.eza.enable = true;
  programs.zoxide.enable = true;
  programs.fzf.enable = true;
  programs.direnv.enable = true;
  programs.zellij.enable = true;

  # Dotfiles
  home.file = {
    ".zfunc".source = "${self}/dots/.zfunc";
    ".local/share/fonts".source = "${self}/dots/fonts";
    ".config/btop".source = "${self}/dots/btop";
    ".config/lazygit".source = "${self}/dots/lazygit";
    ".config/lazydocker".source = "${self}/dots/lazydocker";
    ".config/nvim".source = "${self}/dots/nvim";
    ".config/zellij".source = "${self}/dots/zellij";
    ".config/yazi".source = "${self}/dots/yazi";
  };

  # Packags
  home.packages = with pkgs; [
    fastfetch # System info fetcher (like neofetch)
    ntfs3g # NTFS filesystem support
    brightnessctl # Adjust screen brightness
    bluez-tools # CLI utilities for bluez
    perf-tools # Linux perf wrapper scripts
    sysstat # Performance monitoring tools (iostat, etc.)
    lsof # details about open files
    netcat # Networking utility
    speedtest-cli # Test internet speed
    ripgrep # Fast grep alternative
    playerctl # Control media players
    pamixer # CLI PulseAudio volume controller
    bottom # Modern `top` alternative
    bat # `cat` with syntax highlighting
    delta # Git diff viewer with syntax highlighting
    tealdeer # Fast `tldr` client
    cacert # SSL certificates
    chafa # Terminal image preview
    trash-cli # Send files to trash from CLI
    jq # Command-line JSON processor
    neovim # Modern Vim-based editor
    vim # Terminal text editor
    htop # Interactive process viewer
    duf # Disk usage viewer
    fd # Fast alternative to `find`
    stow # Symlink manager
    unzip # Extract zip files
    wget # Network downloader
    lazygit # Git TUI
    lazydocker # Docker TUI
  ];
}
