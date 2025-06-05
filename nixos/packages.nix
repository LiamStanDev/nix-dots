{ pkgs, ... }:
{
  documentation.man.enable = true;
  documentation.info.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "python-2.7.18.8" "electron-25.9.0" ];
  };

  environment.systemPackages = with pkgs; [
    # Desktop apps
    google-chrome
    telegram-desktop
    wezterm
    kitty
    obs-studio
    rofi
    discord
    obsidian
    pgadmin4-desktopmode
    spotify
    postman
    bitwarden-desktop
    vscode
    libvirt
    pavucontrol

    # Develpment tool
    nix-output-monitor
    gcc
    clang
    gnumake
    gdb
    lldb
    ninja
    cmake
    nodejs
    pnpm
    deno
    bun
    python
    uv
    go
    rustup
    docker
    kubectl
    qemu_full
    qemu-user
    qemu-utils

    # CLI utils
    fastfetch
    wget
    git
    fastfetch
    ntfs3g
    brightnessctl
    openssl
    bluez
    bluez-tools
    vim
    perf-tools # perf
    sysstat # iostat and pidstat
    htop
    netcat
    speedtest-cli
    btop
    duf
    dust
    fd
    ripgrep
    stow
    playerctl
    pamixer

    # Network
    iptables
    iptables-nftables-compat
    nftables

    # Shells
    bash
    zsh

    # Sound
    pipewire
    pulseaudio
    pamixer

    # GPU stuff
    # amdvlk
    # rocm-opencl-icd
    # glaxnimate

    # Wayland
    xwayland
    wl-clipboard
    cliphist

    # Hyperland
    seatd
    hyprland
    hyprland-protocols
    hyprpicker
    hypridle
    gnome-keyring
    fcitx5
    udiskie
    networkmanagerapplet
    swaylock-effects
    waybar
    polkit_gnome
    mako
    wlogout
    swww
    rofi-wayland
  ];

  fonts.packages = with pkgs; [
    fira-sans
    font-awesome
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    roboto
  ];
}
