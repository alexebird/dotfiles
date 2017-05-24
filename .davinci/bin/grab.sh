#!/usr/bin/env bash
#sleep 1
fname=/home/bird/Pictures/screenshots/scrot-$(date +%s).png
scrot -s "${fname}"
rm -f /home/bird/screenshot.png
cp -f "${fname}" /home/bird/screenshot.png
echo "${fname}"
echo /home/bird/screenshot.png
