#!/usr/bin/env bash

# TODO
# if [ "$(cat /sys/class/power_supply/AC/online)" = "0" ]; then
#   systemctl suspend
# fi || true
systemctl suspend
