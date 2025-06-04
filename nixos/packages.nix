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
    alacritty
    wezterm
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

    # network
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
    swaylock-effects
    hyprland
    hyprland-protocols
    seatd
    waybar
    hyprpicker
    mako
    lxqt.lxqt-policykit
    wlogout
    swww
    rofi-wayland
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-mono
    nerd-fonts.caskaydia-cove
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    fira-sans
    font-awesome
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    roboto
  ];
}
