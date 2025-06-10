{
  lib,
  qtbase,
  qtsvg,
  qtgraphicaleffects,
  qtquickcontrols2,
  wrapQtAppsHook,
  stdenvNoCC,
  fetchFromGitHub,
  fetchurl,
}: let
  imgLink = "https://w.wallhaven.cc/full/jx/wallhaven-jx8zyq.png";

  image = fetchurl {
    url = imgLink;
    sha256 = "18kv3dj5kaka9jq7p1123f1fggpdcq8hk8rlhsr2hd13cb1qlymp";
  };
in
  stdenvNoCC.mkDerivation rec {
    pname = "sddm-sugar-dark";
    version = "1..0";

    src = fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-sugar-dark";
      rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
      sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
    };

    nativeBuildInputs = [
      wrapQtAppsHook
    ];

    propagatedUserEnvPkgs = [
      qtbase
      qtsvg
      qtgraphicaleffects
      qtquickcontrols2
    ];

    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sugar-dark
      # cd $out/share/sddm/themes/sugar-dark
      # rm Background.jpg
      # cp -r ${image} $out/share/sddm/themes/sugar-dark/Background.jpg
    '';
  }
