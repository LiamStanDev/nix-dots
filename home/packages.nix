{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      # Desktop applications
      google-chrome
      telegram-desktop
      wezterm
      kitty
      obs-studio
      discord
      obsidian
      pgadmin4-desktopmode
      spotify
      postman
      bitwarden-desktop
      vscode
      pavucontrol
      nautilus
      virt-manager


      # CLI utilities
      fastfetch # system information fetcher
      ntfs3g # NTFS filesystem support
      brightnessctl # control screen brightness
      bluez # Bluetooth protocol stack
      bluez-tools # Bluetooth utilities
      perf-tools # Linux performance analysis tools
      sysstat # system performance monitoring (iostat, pidstat)
      netcat # networking utility (nc)
      speedtest-cli # internet speed test
      ripgrep # fast text searching (grep alternative)
      playerctl # media player controller
      pamixer # PulseAudio volume control
      cliphist # clipboard history manager
      bottom # system monitor (top alternative)
      bat # cat clone with syntax highlighting
      delta # improved git diff viewer
      zellij # terminal workspace manager (tmux alternative)
      tealdeer # fast tldr client
      cacert # SSL certificates
      chafa # terminal image previewer
      eza # enhanced ls
      fzf # fuzzy finder
      yazi # terminal file manager
      zoxide # smarter cd command
      trash-cli # command line trash
      jq # JSON processor
      neovim # text editor
      lazygit # simple terminal UI for git
      lazydocker # simple terminal UI for docker
      direnv # environment variable manager
      starship # minimal, fast shell prompt
      zoxide # smarter cd command

      # Hyprland & Wayland user tools
      hyprpicker
      hypridle
      gnome-keyring
      polkit_gnome
      udiskie
      networkmanagerapplet
      waybar
      mako
      swww
      rofi-wayland
      grim
      slurp
      swaylock-effects
      libnotify # notify-send

      # Development/libraries/themes
      python313

      # Qt theme
      (catppuccin-kvantum.override {
        accent = "blue";
        variant = "frappe";
      })
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
    ];
}
