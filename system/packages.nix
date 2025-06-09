{ pkgs, pkgs-stable, ... }: {
  documentation.man.enable = true;
  documentation.info.enable = true;

  environment.systemPackages = with pkgs; [
    # Boot
    catppuccin-grub

    # Build/Dev tools 
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

    # Virtualization
    docker
    kubectl
    qemu_full
    qemu-user
    qemu-utils
    libvirt

    # CLI utilities
    git # version control
    vim # text editor
    htop # process viewer
    duf # disk usage/free utility
    dust # disk usage analyzer
    fd # simple, fast and user-friendly alternative to 'find'
    ripgrep # fast text searching (grep alternative)
    stow # symlink farm manager
    unzip # extract zip files
    wget # network downloader
    openssl # SSL/TLS toolkit

    # Network
    iptables
    iptables-nftables-compat
    nftables

    # Shells
    bash
    zsh

    # Sound
    pipewire

    # GPU stuff
    # amdvlk
    # rocm-opencl-icd
    # glaxnimate

    # Wayland
    xwayland
    wl-clipboard

    # Hyperland
    seatd
    hyprland
    hyprland-protocols
  ];
}
