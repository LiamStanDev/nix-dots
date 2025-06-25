{
  config,
  pkgs,
  inputs,
  lib,
  wheelUser,
  ...
}: {
  imports = [
    ./nixpkgs.nix
    ./substituters.nix
  ];

  # we need git for flakes
  environment.systemPackages = [pkgs.git];

  # Run unpatched dynamic binaries on NixOS
  # see: https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/programs/nix-ld.nix
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    alsa-lib # lib for ALSA sound system
    at-spi2-atk
    at-spi2-core
    atk
    cairo # 2D graphics library
  ];

  programs.nh = {
    enable = true;
    # Automatic garbage collection
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
    flake = "/home/${wheelUser}/nix-dots";
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
  in {
    package = pkgs.lix; # community nix flake manager

    # pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry = lib.mapAttrs (_: v: {flake = v;}) flakeInputs;

    # set the path for channels compat
    nixPath =
      lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      flake-registry = "/etc/nix/registry.json";

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      trusted-users = ["root" "@wheel"];

      accept-flake-config = false;
      warn-dirty = false;
    };
  };
}
