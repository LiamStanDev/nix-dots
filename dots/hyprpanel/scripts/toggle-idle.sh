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
  echo ""
else
  systemctl --user start hypridle.service
  echo ""
fi
