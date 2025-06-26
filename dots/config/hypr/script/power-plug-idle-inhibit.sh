#!/usr/bin/env bash

if upower -d | grep -q 'online:\s*no'; then
  systemctl suspend || true
fi
