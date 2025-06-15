{
  pkgs,
  lib,
  ...
}: let
  colors = {
    dark = {
      foreground = "c6d0f5";
      background = "303446";
      regular0 = "51576d"; # black
      regular1 = "e78284"; # red
      regular2 = "a6d189"; # green
      regular3 = "e5c890"; # yellow
      regular4 = "8caaee"; # blue
      regular5 = "f4b8e4"; # magenta
      regular6 = "81c8be"; # cyan
      regular7 = "b5bfe2"; # white
      bright0 = "626880"; # bright black
      bright1 = "e78284"; # bright red
      bright2 = "a6d189"; # bright green
      bright3 = "e5c890"; # bright yellow
      bright4 = "8caaee"; # bright blue
      bright5 = "f4b8e4"; # bright magenta
      bright6 = "81c8be"; # bright cyan
      bright7 = "a5adce"; # bright white
    };

    light = {
      foreground = "4c4f69";
      background = "f2d5cf";
      regular0 = "ccd0da"; # black
      regular1 = "e78284"; # red
      regular2 = "a6d189"; # green
      regular3 = "e5c890"; # yellow
      regular4 = "8caaee"; # blue
      regular5 = "f4b8e4"; # magenta
      regular6 = "81c8be"; # cyan
      regular7 = "b5bfe2"; # white
      bright0 = "bcc0cc"; # bright black
      bright1 = "e78284"; # bright red
      bright2 = "a6d189"; # bright green
      bright3 = "e5c890"; # bright yellow
      bright4 = "8caaee"; # bright blue
      bright5 = "f4b8e4"; # bright magenta
      bright6 = "81c8be"; # bright cyan
      bright7 = "a5adce"; # bright white
    };
  };
in {
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "JetBrains Mono Nerd Font:size=10";
        horizontal-letter-offset = 0;
        vertical-letter-offset = 0;
        pad = "4x4 center";
        selection-target = "clipboard";
      };

      bell = {
        urgent = "yes";
        notify = "yes";
      };

      scrollback = {
        lines = 10000;
        multiplier = 3;
        indicator-position = "relative";
        indicator-format = "line";
      };

      cursor = {
        style = "beam";
        beam-thickness = 1;
      };

      colors =
        {
          alpha = 0.9;
        }
        // colors.dark;
    };
  };
}
