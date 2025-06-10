# ──────── 🖥️ Virtualization / Containers / K8s ────────
{pkgs, ...}: {
  home.packages = with pkgs; [
    docker # Container engine
    kubectl # Kubernetes CLI
    qemu_full # Full system emulation
    qemu-user # QEMU user-mode emulation
    libvirt # Virtualization management daemon
  ];
}
