#!/usr/bin/env bash

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
  grim -g "$(slurp)" "$savepath"
  pkill slurp
  notify-send -i "$savepath" "Screenshot saved to $savepath"
else
  grim -l 0 -g "$(slurp)" - | wl-copy
  pkill slurp
  notify-send "Screenshot copied to clipboard"
fi
