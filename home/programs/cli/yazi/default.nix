{self, ...}: {
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
  };

  home.file = {
    ".config/yazi".source = "${self}/dots/yazi";
  };
}
