#!/usr/bin/env bash

# Okayama City
LAT="34.655"
LON="133.919"

# fetch
data=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&current=temperature_2m,weather_code")

# safe temperature extract (fallbacks included)
temp=$(echo "$data" | jq -r '
  .current.temperature_2m
  // .current.temperature
  // .hourly.temperature_2m[0]
  // empty
')

# if empty, show "--"
if [ -z "$temp" ]; then
  temp="--"
fi

# weather code
code=$(echo "$data" | jq -r '.current.weather_code // empty')

# icon convert
case $code in
  0)   icon="  " ;;
  1|2) icon="  " ;;
  3)   icon="  " ;;
  45|48) icon="  " ;;
  51|53|55) icon="  " ;;
  61|63|65) icon="  " ;;
  66|67) icon="  " ;;
  71|73|75) icon="  " ;;
  77) icon="  " ;;
  80|81|82) icon="  " ;;
  95) icon="  " ;;
  96|99) icon="  " ;;
  *) icon="" ;;
esac

echo -n "$icon ${temp}℃"

