# ──────── 🛠️ Development Tools ────────
{
  inputs,
  lib,
  config,
  pkgs,
}: let
  cfg = config.boundle.dev;
in {
  optinos.boundle.dev = {enable = lib.mkEnableOption "dev";};

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gcc # GNU Compiler Collection
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
      python # Python 3 default interpreter
      python313 # Python 3.13 interpreter
      uv # Python package manager (ultrafast pip)
      nix-output-monitor # Enhanced output viewer for nix builds
    ];
  };
}
