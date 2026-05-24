#!/bin/sh

df -h "$HOME" 2>/dev/null | awk 'NR==2 {
  printf " %s/%s", $4, $2
}'
