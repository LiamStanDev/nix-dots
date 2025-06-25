#!/usr/bin/env bash

PID_FILE="/tmp/idle_inhibit.pid"

function is_inhibit_active() {
  [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null
}

function start_inhibit() {
  systemd-inhibit --what=idle:sleep --why="Manual idle inhibit toggle" \
    bash -c 'while true; do sleep 1000; done' &
  echo $! >"$PID_FILE" # get process id and save to pid file
  notify-send "Idle Inhibit" "☕ Idle inhibit enabled"
}

function stop_inhibit() {
  if is_inhibit_active; then
    kill "$(cat "$PID_FILE")" && rm -f "$PID_FILE" # kill process by pid and remove pid file
    notify-send "Idle Inhibit" "🌙 Idle inhibit disabled"
  fi
}

#   
if [[ "$1" == "--status" ]]; then
  if is_inhibit_active; then
    echo "☕ "
  else
    echo "🌙 "
  fi
  exit 0
fi

if is_inhibit_active; then
  stop_inhibit
else
  start_inhibit
fi
