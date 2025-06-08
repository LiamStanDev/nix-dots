{ inputs, ... }: {
  imports = [
    # make home manager us moduele of nixos
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
