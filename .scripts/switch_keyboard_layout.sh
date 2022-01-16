#!/bin/bash
CURRENT=$(setxkbmap -query | grep layout | awk '{print $2}')
if [ "$CURRENT" == "us" ]
  then
    setxkbmap it
  else
    setxkbmap us
fi
