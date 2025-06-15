{
  self,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    ghostty-bin
  ];

  home.file.".config/ghostty".source = "${self}/dots/ghostty";
}
