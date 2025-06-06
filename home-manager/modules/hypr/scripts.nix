{ pkgs, ... }:

# TODO:
{
  show-clients = {
    type = "app";
    program = pkgs.writeShellApplication {
      name = "show-client";
      text = ''
        clientinfo = hyprctl clients -j | jq '.[] | {class: .class, title: .title}'
        notify-send ${clientinfo}
      '';
      runtimeInputs = [ pkgs.jq pkgs.hyprland ];
    };
  };
}
