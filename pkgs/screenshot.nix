# Screen shot command
# You can test by the following command
# cd $(nix-build ./screenshot.nix --no-link)
{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellScriptBin "screenshot" ''
  save=0
  savepath="$HOME/Pictures/screenshot/screenshot-$(date +%s).png"
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --save)
        save=1
        shift
        ;;
      *)
        shift
        ;;
    esac
  done

  if [ "$save" -eq 1 ]; then
    mkdir -p "$(dirname "$savepath")"
    ${pkgs.grim}/bin/grim -g "$(slurp)" "$savepath"
    ${pkgs.libnotify}/bin/notify-send -i "$savepath" "Screenshot saved to $savepath"
  else
    ${pkgs.grim}/bin/grim -l 0 -g "$(slurp)" - | ${pkgs.wl-clipboard}/bin/wl-copy
    ${pkgs.libnotify}/bin/notify-send "Screenshot copied to clipboard"
  fi
''
