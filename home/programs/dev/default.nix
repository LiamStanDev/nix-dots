# ──────── 🛠️ Development Tools ────────
{
  inputs,
  pkgs,
  ...
}: {
  imports = [./lsp.nix];

  home.packages = with pkgs; [
    (hiPrio gcc) # GNU Compiler Collection
    clang # C language family compiler
    gnumake # Build automation tool
    gdb # GNU debugger
    lldb # LLVM debugger
    ninja # Small, fast build system
    cmake # Cross-platform build system
    rustup # Rust toolchain installer
    go # Go programming language
    nodejs # JavaScript runtime
    pnpm # Fast, disk space-efficient JS package manager
    deno # Secure JS/TS runtime
    bun # All-in-one JS runtime/toolkit
    python313 # Python 3.13 interpreter
    uv # Python package manager (ultrafast pip)
    nix-output-monitor # Enhanced output viewer for nix builds
    dtc # Device Tree Compiler (for qemu development)
  ];
}
