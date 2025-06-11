# ──────── 🖥️ Virtualization / Containers / K8s ────────
{pkgs, ...}: {
  home.packages = with pkgs; [
    kubectl # Kubernetes CLI
    qemu_full # Full system emulation
    qemu-user # QEMU user-mode emulation
    virt-manager # Virtual machine GUI frontend
    spice
    spice-gtk
    spice-protocol
    swtpm
  ];

  # Enable OVMF,  see: https://nixos.wiki/wiki/Libvirt#Configuration
  home.file.".config/libvirt/qemu.conf".text = ''
    # Adapted from /var/lib/libvirt/qemu.conf
    # Note that AAVMF and OVMF are for Aarch64 and x86 respectively
    nvram = [
      "/run/libvirt/nix-ovmf/AAVMF_CODE.fd:/run/libvirt/nix-ovmf/AAVMF_VARS.fd",
      "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd"
    ];
  '';
}
