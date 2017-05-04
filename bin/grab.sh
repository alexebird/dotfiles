#!/usr/bin/env bash
#sleep 1
fname=/home/bird/Pictures/screenshots/scrot-$(date +%s).png
scrot -s "${fname}"
rm /home/bird/scrot.png
cp -f "${fname}" /home/bird/scrot.png
