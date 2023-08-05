#!/usr/bin/env sh

sketchybar --add item calendar right \
  --set calendar update_freq=15 \
  icon.color=$BLACK \
  icon.padding_left=10 \
  label.color=$WHITE \
  label.padding_right=16 \
  script="$PLUGIN_DIR/calendar.sh" \
  background.height=26 \
  background.color=$BLACK \
  background.corner_radius=$CORNER_RADIUS \
  background.padding_right=5
