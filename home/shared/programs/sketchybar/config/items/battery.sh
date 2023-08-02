#!/usr/bin/env sh

sketchybar --add item battery right \
	--set battery \
	update_freq=3 \
	icon.color=$WHITE \
	icon.padding_left=14 \
	label.color=$WHITE \
	label.padding_right=10 \
	background.color=$BLACK \
	background.height=26 \
	background.corner_radius=$CORNER_RADIUS \
	background.padding_right=5 \
	script="$PLUGIN_DIR/power.sh"
