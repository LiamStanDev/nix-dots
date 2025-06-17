{
  self,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # only include astal3, astal4, and astal-io
    inputs.ags.homeManagerModules.default
  ];

  programs.ags = {
    enable = true;

    # symlink to ~/.config/ags
    configDir = "${self}/dots/ags";

    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      # see: https://github.com/Aylur/astal/blob/main/flake.nix
      inputs.ags.packages.${pkgs.system}.apps
      inputs.ags.packages.${pkgs.system}.battery
      inputs.ags.packages.${pkgs.system}.notifd
      inputs.ags.packages.${pkgs.system}.hyprland
      inputs.ags.packages.${pkgs.system}.network
      inputs.ags.packages.${pkgs.system}.powerprofiles
      inputs.ags.packages.${pkgs.system}.bluetooth
      inputs.ags.packages.${pkgs.system}.wireplumber
      fzf
    ];
  };

  home.packages = [
    inputs.ags.packages.${pkgs.system}.io
    inputs.ags.packages.${pkgs.system}.notifd
  ];
}
