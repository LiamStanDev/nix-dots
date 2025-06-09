#!/usr/bin/env bash

if [[ "$1" == "--status" ]]; then
  if systemctl --user is-active --quiet hypridle.service; then
    echo ""
  else
    echo ""
  fi
  exit 0
fi

if systemctl --user is-active --quiet hypridle.service; then
  systemctl --user stop hypridle.service
  notify-send "Idle stop"
  echo ""
else
  systemctl --user start hypridle.service
  notify-send "Idle running"
  echo ""
fi
