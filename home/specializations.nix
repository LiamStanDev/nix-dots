{
  # wallpaper = let
  #   url = "https://images.unsplash.com/photo-1529528744093-6f8abeee511d?ixlib=rb-4.0.3&q=85&fm=jpg&crop=fit&cs=srgb&w=2560";
  #   sha256 = "18r5hmzglifysjmwn5j89gbbk56lbfb3f2jzwp432lr8gb5n7q8v";
  #   ext = "jpg";

  # wallpaper = let
  #   url = "https://w.wallhaven.cc/full/jx/wallhaven-jx9mzp.png";
  #   sha256 = "13znkrmfsdhn7ppcxky94gz7z7gpv8fwnkhfawdrza9ga1zfqln3";
  #   ext = "png";
  # in
  #   builtins.fetchurl {
  #     name = "wallpaper-${sha256}.${ext}";
  #     inherit url sha256;
  #   };

  wallpaper = ./wallpapers/Kraken.png;

  lockscreen = let
    url = "https://w.wallhaven.cc/full/jx/wallhaven-jx8zyq.png";
    sha256 = "18kv3dj5kaka9jq7p1123f1fggpdcq8hk8rlhsr2hd13cb1qlymp";
    ext = "png";
  in
    builtins.fetchurl {
      name = "lockscreen-${sha256}.${ext}";
      inherit url sha256;
    };
}
