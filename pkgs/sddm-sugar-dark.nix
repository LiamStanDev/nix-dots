{pkgs ? import <nixpkgs> {}}: let
  image = ../wallpapers/land-moon.jpg;
in
  pkgs.stdenv.mkDerivation {
    pname = "sddm-sugar-dark";
    version = "1..0";

    src = pkgs.fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-sugar-dark";
      rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
      sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
    };

    installPhase = ''
      mkdir -p $out/share/sddm/themes
      rm ./Background.jpg
      cp ${image} ./Background.jpg
      cp -R . $out/share/sddm/themes/sugar-dark
    '';
  }
