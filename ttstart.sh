#!/bin/sh
#
# Run TT Start console on X11 display
#
export DISPLAY=:0.0
xset s 0
xset s off
xset -dpms
amixer set Beep 0 mute
amixer set Master 100% unmute
amixer set PCM 100%
exec "${HOME}/Documents/metarace/venv/bin/ttstart"
