#!/usr/bin/env bash

output=""
for zone in /sys/class/thermal/thermal_zone*; do
  name=$(<"$zone/type")
  temp_raw=$(<"$zone/temp")
  temp_c=$(awk "BEGIN { printf \"%.1f\", $temp_raw / 1000 }")
  output+="$name: ${temp_c}°C\n"
done

# Main bar text (just CPU temp or generic label)
main_temp=$(awk "BEGIN { printf \"%.0f\", $(</sys/class/thermal/thermal_zone12/temp) / 1000 }")
echo "{\"text\": \"🌡️ ${main_temp}°C\", \"tooltip\": \"${output}\"}"
