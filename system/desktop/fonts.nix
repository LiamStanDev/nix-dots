{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-symbols
      font-awesome

      # Sans(Serif) fonts
      libertinus
      fira-sans
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      roboto
      (google-fonts.override {fonts = ["Inter"];})

      # monospace fonts
      jetbrains-mono

      # nerdfonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
    ];

    # causes more issues than it solves
    enableDefaultPackages = false;

    # user defined fonts
    fontconfig.defaultFonts = {
      serif = ["Libertinus Serif" "Noto Serif CJK SC"];
      sansSerif = ["Inter" "Noto Sans CJK SC"];
      monospace = ["JetBrains Mono Nerd Font"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
