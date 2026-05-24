#!/bin/sh

free -m 2>/dev/null | awk '/Mem:/ {
  used=$3/1024;
  total=$2/1024;
  printf " %.1fGB/%.1fGB", used, total
}'
