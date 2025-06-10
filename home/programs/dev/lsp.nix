{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # LSP
    clang-tools # C/C++
    cmake-language-server # CMake
    # rust-analyzer # Rust ps. already install by rustup
    taplo # Toml
    typescript-language-server # JS/TS
    pyright # Python
    lua-language-server # Lua
    docker-language-server # Docker
    docker-compose-language-service # Docker compose
    bash-language-server # Bash/Zsh
    nixd # Nix

    # Formatter
    alejandra # Nix
    stylua # Lua
    ruff # Python
    shfmt # Bash/Zsh
    prettierd # JS/TS
    gersemi # CMake
  ];

  # for nix flake
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
