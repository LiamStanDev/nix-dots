#!/bin/bash
if [[ "$1" == "--status" ]]; then
  if systemctl --user is-active --quiet swayidle.service; then
    echo ""
  else
    echo ""
  fi
  exit 0
fi

if systemctl --user is-active --quiet swayidle.service; then
  systemctl --user stop swayidle.service
  notify-send "Swayidle stop"
  echo ""
else
  systemctl --user start swayidle.service
  notify-send "Swayidle running"
  echo ""
fi

