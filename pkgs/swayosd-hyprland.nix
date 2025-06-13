{pkgs ? import <nixpkgs> {}}: let
  swayosdVolumeRaise = pkgs.writeShellApplication {
    name = "swayosd-volume-raise";
    runtimeInputs = [pkgs.swayosd pkgs.jq pkgs.hyprland];
    text = ''
      MONITOR="$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')"
      swayosd-client --monitor "$MONITOR" --output-volume raise "$@"
    '';
  };

  swayosdVolumeLower = pkgs.writeShellApplication {
    name = "swayosd-volume-lower";
    runtimeInputs = [pkgs.swayosd pkgs.jq pkgs.hyprland];
    text = ''
      MONITOR="$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')"
      swayosd-client --monitor "$MONITOR" --output-volume lower "$@"
    '';
  };

  swayosdBrightnessRaise = pkgs.writeShellApplication {
    name = "swayosd-brightness-raise";
    runtimeInputs = [pkgs.swayosd pkgs.jq pkgs.hyprland];
    text = ''
      MONITOR="$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')"
      swayosd-client --monitor "$MONITOR" --brightness raise "$@"
    '';
  };

  swayosdBrightnessLower = pkgs.writeShellApplication {
    name = "swayosd-brightness-lower";
    runtimeInputs = [pkgs.swayosd pkgs.jq pkgs.hyprland];
    text = ''
      MONITOR="$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')"
      swayosd-client --monitor "$MONITOR" --brightness lower "$@"
    '';
  };

  swayosdVolumeMuteToggle = pkgs.writeShellApplication {
    name = "swayosd-volume-mute-toggle";
    runtimeInputs = [pkgs.swayosd pkgs.jq pkgs.hyprland];
    text = ''
      MONITOR="$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')"
      swayosd-client --monitor "$MONITOR" --output-volume mute-toggle "$@"
    '';
  };

  swayosdMicMuteToggle = pkgs.writeShellApplication {
    name = "swayosd-mic-mute-toggle";
    runtimeInputs = [pkgs.swayosd pkgs.jq pkgs.hyprland];
    text = ''
      MONITOR="$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')"
      swayosd-client --monitor "$MONITOR" --input-volume mute-toggle "$@"
    '';
  };
in
  pkgs.buildEnv {
    name = "swayosd-apps";
    paths = [
      swayosdVolumeRaise
      swayosdVolumeLower
      swayosdBrightnessRaise
      swayosdBrightnessLower
      swayosdVolumeMuteToggle
      swayosdMicMuteToggle
    ];
  }
