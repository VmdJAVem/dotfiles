#!/bin/sh

df -h $HOME | awk 'NR==2 {
  print " " $4 "/" $2
}'
