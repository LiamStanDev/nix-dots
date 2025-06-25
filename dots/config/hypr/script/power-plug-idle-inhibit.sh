#!/usr/bin/env bash

if [[ -f /sys/class/power_supply/AC/online ]] && [[ "$(cat /sys/class/power_supply/AC/online)" = "0" ]]; then
  systemctl suspend || true
fi
